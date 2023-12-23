//
//  RenderScene.swift
//  Metalim
//
//  Created by Nizamet Özkan on 7.12.2023.
//

import Foundation

class GameScene: ObservableObject {

    @Published var player: Entity
    @Published var sun: Light
    @Published var spotlight: Light
    @Published var billboard: Billboard
    @Published var cubes: [Entity]
    @Published var groundTiles: [Entity]
    @Published var pointLights: [BrightBillBoard]

    init() {
        groundTiles = []
        cubes = []
        pointLights = []

        let newPlayer = Entity()
        newPlayer.addCameraComponent(position: [-6.0, 6.0, 4.0], eulers: [0.0, 110.0, -45.0])
        player = newPlayer

        let newBillboard = Billboard(position: [0.0, 0.0, 2.7])
        billboard = newBillboard

        let newSpotlight = Light(color: [1.0, 0.0, 0.0])
        newSpotlight.declareSpotlight(position: [-2, 0.0, 3.0], eulers: [0.0, 0.0, 180.0], eulerVelocity: [0.0, 0.0, 45.0])
        spotlight = newSpotlight;

        let newSun = Light(color: [1.0, 1.0, 0.0])
        newSun.declareDirectional(eulers: [0.0, 135.0, 45.0])
        sun = newSun
        sun.update()

        let newCube = Entity()
        newCube.addTransformComponent(position: [0.0, 0.0, 1.0], eulers: [0.0, 0.0, 0.0])
        cubes.append(newCube)

        let newTile = Entity()
        newTile.addTransformComponent(position: [0.0, 0.0, 0.0], eulers: [90.0, 0.0, 0.0])
        groundTiles.append(newTile)

        var newPointLight = BrightBillBoard(position: [0.0, 0.0, 1.0], color: [0.0, 1.0, 1.0], rotationCenter: [0.0, 0.0, 1.0], pathRadius: 2.0, pathPhi: 60.0, angularVelocity: 1.0)
        pointLights.append(newPointLight)
        newPointLight = BrightBillBoard(position: [0.0, 0.0, 1.0], color: [0.0, 0.0, 1.0], rotationCenter: [0.0, 0.0, 1.0], pathRadius: 3.0, pathPhi: 0.0, angularVelocity: 2.0)
        pointLights.append(newPointLight)

    }

    func updateView() {
        self.objectWillChange.send()
    }

    func update() {

        player.update()

        for cube in cubes {
            cube.update()
        }

        for ground in groundTiles {
            ground.update()
        }

        spotlight.update()

        for light in pointLights {
            light.update(viewerPosition: player.position!)
        }

        billboard.update(viewwerPosition: player.position!)

        updateView()
    }

    func strafePlayer(offset: CGSize) {
        let rightAmount: Float = Float(offset.width) / 1000
        let upAmount: Float = Float(offset.height) / 1000

        player.stafe(rightAmount: rightAmount, upAmount: upAmount)
    }
}
