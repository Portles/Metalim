//
//  SimpleComponent.swift
//  Metalim
//
//  Created by Nizamet Özkan on 7.12.2023.
//

import Foundation

class SimpleComponent {

    var position: simd_float3
    var eulers: simd_float3

    init(position: simd_float3, eulers: simd_float3) {
        self.position = position
        self.eulers = eulers
    }
}
