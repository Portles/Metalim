//
//  ContentView.swift
//  Metalim
//
//  Created by Nizamet Özkan on 21.11.2023.
//

import SwiftUI
import MetalKit

struct ContentView: NSViewRepresentable {

    @EnvironmentObject var gameScene: GameScene

    func makeCoordinator() -> Renderer {
        Renderer(self, scene: gameScene)
    }

    func makeNSView(context: NSViewRepresentableContext<ContentView>) -> MTKView {

        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true

        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }

        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        mtkView.isPaused = false
        mtkView.depthStencilPixelFormat = .depth32Float

        return mtkView
    }

    func updateNSView(_ nsView: NSViewType, context: NSViewRepresentableContext<ContentView>) {

    }
}

#Preview {
    ContentView()
}
