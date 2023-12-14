//
//  Billboard.swift
//  Metalim
//
//  Created by Nizamet Özkan on 14.12.2023.
//

import Foundation

class Billboard {
    var position: simd_float3
    var model: matrix_float4x4

    init(position: simd_float3) {
        self.position = position
        self.model = Matrix44.create_identity()
    }

    func update(viewwerPosition: simd_float3) {

        let selfToViewer: simd_float3 = viewwerPosition - position
        let theta: Float = simd.atan2(selfToViewer[1], selfToViewer[0]) * 180.0 / .pi
        let horizontalDistance: Float = sqrtf(selfToViewer[0] * selfToViewer[0] + selfToViewer[1] * selfToViewer[1])
        let phi: Float = simd.atan2(selfToViewer[2], horizontalDistance) * 180.0 / .pi

        model = Matrix44.create_from_rotation(eulers: [0, phi, theta])
        model = Matrix44.create_from_translation(translation: position) * model
    }
}
