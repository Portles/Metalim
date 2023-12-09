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
        ContentView()
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        gameScene.spinPlayer(offset: gesture.translation)
                    })
            )
    }
}

#Preview {
    AppView().environmentObject(GameScene())
}
