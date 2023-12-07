//
//  Renderer.swift
//  Metalim
//
//  Created by Nizamet Özkan on 6.12.2023.
//

import MetalKit

class Renderer: NSObject, MTKViewDelegate {

    var parent: ContentView
    var metalDevice: MTLDevice!
    var metalComandQueue: MTLCommandQueue!
    let pipelineState: MTLRenderPipelineState
    var scene: RenderScene
    var mesh: TriangleMesh

    init(_ parent: ContentView) {
        
        self.parent = parent
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalComandQueue = metalDevice.makeCommandQueue()

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let library = metalDevice.makeDefaultLibrary()
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        do {
            try pipelineState = metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError()
        }

        mesh = TriangleMesh(metalDevice: metalDevice)
        scene = RenderScene()

        super.init()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }
    
    func draw(in view: MTKView) {

        scene.update()

        guard let drawable = view.currentDrawable else {
            return
        }

        let commandBuffer = metalComandQueue.makeCommandBuffer()

        let renderPassDescriptor = view.currentRenderPassDescriptor
        renderPassDescriptor?.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1.0)
        renderPassDescriptor?.colorAttachments[0].loadAction = .clear
        renderPassDescriptor?.colorAttachments[0].storeAction = .store

        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)

        for triangle in scene.triangles {
            var modelMatrix: matrix_float4x4 = Matrix44.create_from_rotation(eulers: triangle.eulers)
            modelMatrix = Matrix44.create_from_translation(translation: triangle.position) * modelMatrix;
            renderEncoder?.setVertexBytes(&modelMatrix, length: MemoryLayout<matrix_float4x4>.stride, index: 1)

            renderEncoder?.setRenderPipelineState(pipelineState)
            renderEncoder?.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
            renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        }


        renderEncoder?.endEncoding()

        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
