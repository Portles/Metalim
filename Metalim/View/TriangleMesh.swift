//
//  TriangleMesh.swift
//  Metalim
//
//  Created by Nizamet Özkan on 7.12.2023.
//

import MetalKit

class TriangleMesh {
    let vertexBuffer: MTLBuffer

    init(metalDevice: MTLDevice) {

        let vertices: [Vertex] = [
            Vertex(position: [-1, -1, 0], color: [1, 0, 0, 1]),
            Vertex(position: [1, -1, 0], color: [0, 1, 0, 1]),
            Vertex(position: [0, 1, 0], color: [0, 0, 1, 1])
        ]
        vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])!
    }
}
