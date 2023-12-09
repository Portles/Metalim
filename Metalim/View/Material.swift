//
//  Material.swift
//  Metalim
//
//  Created by Nizamet Özkan on 9.12.2023.
//

import Foundation

import MetalKit

class Material {

    let texture: MTLTexture
    let sampler: MTLSamplerState

    init(device: MTLDevice, allocator: MTKTextureLoader, filename: String) {

        guard let materialUrl = Bundle.main.url(forResource: filename, withExtension: "png") else {
            fatalError()
        }

        let options: [MTKTextureLoader.Option : Any] = [
            .SRGB: false
        ]

        do {
            texture = try allocator.newTexture(URL: materialUrl, options: options)
        } catch {
            fatalError("Couldn't load mesh.")
        }

        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.sAddressMode = .repeat
        samplerDescriptor.tAddressMode = .repeat
        samplerDescriptor.minFilter = .nearest
        samplerDescriptor.magFilter = .linear

        sampler = device.makeSamplerState(descriptor: samplerDescriptor)!
    }
}
