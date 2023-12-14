//
//  AppView.swift
//  Metalim
//
//  Created by Nizamet Özkan on 9.12.2023.
//

import SwiftUI

struct AppView: View {

    @EnvironmentObject var gameScene: GameScene

    var body: some View {
        VStack {
            ContentView()
                .gesture(
                    DragGesture()
                        .onChanged({ gesture in
                            gameScene.strafePlayer(offset: gesture.translation)
                        })
                )

            Text("Debug Info")
        }
        VStack {
            Text("Camera")
            HStack {
                Text("Position")
                VStack {
                    Text(String(gameScene.player.position![0]))
                    Text(String(gameScene.player.position![1]))
                    Text(String(gameScene.player.position![2]))
                }
                Text("Distance")
                Text(String(simd.length(gameScene.player.forwards!)))
                Text("Forwards")
                VStack {
                    Text(String(gameScene.player.forwards![0]))
                    Text(String(gameScene.player.forwards![1]))
                    Text(String(gameScene.player.forwards![2]))
                }
                Text("Right")
                VStack {
                    Text(String(gameScene.player.right![0]))
                    Text(String(gameScene.player.right![1]))
                    Text(String(gameScene.player.right![2]))
                }
                Text("Up")
                VStack {
                    Text(String(gameScene.player.up![0]))
                    Text(String(gameScene.player.up![1]))
                    Text(String(gameScene.player.up![2]))
                }
            }
        }
    }
}

#Preview {
    AppView().environmentObject(GameScene())
}
