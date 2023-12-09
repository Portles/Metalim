//
//  MetalimApp.swift
//  Metalim
//
//  Created by Nizamet Özkan on 21.11.2023.
//

import SwiftUI

@main
struct MetalimApp: App {

    @StateObject private var gameScene = GameScene()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(gameScene)
        }
    }
}
