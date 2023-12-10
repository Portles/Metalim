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

        let options: [MTKTextureLoader.Option: Any] = [
            .SRGB: false,
            .generateMipmaps: true
        ]

        do {
            texture = try allocator.newTexture(name: filename, scaleFactor: 1.0, bundle: Bundle.main, options: options)
        } catch {
            fatalError("couldn't load mesh")
        }

        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.sAddressMode = .repeat
        samplerDescriptor.tAddressMode = .repeat
        samplerDescriptor.magFilter = .linear
        samplerDescriptor.minFilter = .nearest
        samplerDescriptor.mipFilter = .linear
        samplerDescriptor.maxAnisotropy = 8

        sampler = device.makeSamplerState(descriptor: samplerDescriptor)!
    }
}
