//
//  Entity.swift
//  Metalim
//
//  Created by Nizamet Özkan on 10.12.2023.
//

import Foundation

class Entity {
    var hasTransformComponent: Bool
    var position: simd_float3?
    var eulers: simd_float3?
    var model: matrix_float4x4?

    var hasCameraComponent: Bool
    var forwards: vector_float3?
    var right: vector_float3?
    var up: vector_float3?
    var view: matrix_float4x4?

    var hasLightComponent: Bool
    var color: vector_float3?
    var lightType: lightType?

    init() {
        self.hasTransformComponent = false
        self.hasCameraComponent = false
        self.hasLightComponent = false
    }

    func addTransformComponent(position: simd_float3, eulers: simd_float3) {
        self.hasTransformComponent = true
        self.position = position
        self.eulers = eulers
        update()
    }

    func addCameraComponent(position: simd_float3, eulers: simd_float3) {
        self.hasCameraComponent = true
        self.position = position
        self.eulers = eulers
        update()
    }

    func addLightComponent(eulers: vector_float3, color: simd_float3) {
        self.hasLightComponent = true
        self.color = color
        self.eulers = eulers
        self.lightType = DIRECTIONAL
    }

    func stafe(rightAmount: Float, upAmount: Float) {
        position = position! + rightAmount * right! + upAmount * up!

        let distance: Float = simd.length(position!)

        moveForwards(amount: distance - 10.0)
    }

    func moveForwards(amount: Float) {
        position = position! + amount * forwards!
    }

    func update() {

        if hasTransformComponent {
            model = Matrix44.create_from_rotation(eulers: eulers!)
            model = Matrix44.create_from_translation(translation: position!) * model!
        }

        if hasCameraComponent {
            forwards = simd.normalize([0,0,0] - position!)

            let globalUp: vector_float3 = [0.0, 0.0, 1.0]

            right = simd.normalize(simd.cross(globalUp, forwards!))

            up = simd.normalize(simd.cross(forwards!, right!))

            view = Matrix44.create_lookat(eye: position!, target: [0,0,0] + forwards!, up: up!)
        }

        if hasLightComponent {
            if lightType == DIRECTIONAL {
                forwards = [
                    cos(eulers![2] * .pi / 180.0) * sin(eulers![1] * .pi / 180.0),
                    sin(eulers![2] * .pi / 180.0) * sin(eulers![1] * .pi / 180.0),
                    cos(eulers![1] * .pi / 180.0)
                ]
            }
        }
    }
}
