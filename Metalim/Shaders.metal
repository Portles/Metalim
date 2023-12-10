//
//  Shaders.metal
//  Metalim
//
//  Created by Nizamet Özkan on 6.12.2023.
//

#include <metal_stdlib>
using namespace metal;

#include "definitions.h"

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float2 texcoord [[ attribute(1) ]];
};

struct Fragment {
    float4 position [[position]];
    float2 texcoord;;
};

vertex Fragment vertexShader(const VertexIn vertex_in [[ stage_in ]], constant matrix_float4x4 &model [[buffer(1)]], constant CameraParameters &camera [[buffer(2)]]) {

    Fragment output;
    output.position = camera.projection * camera.view * model * vertex_in.position;
    output.texcoord = vertex_in.texcoord;

    return output;
}

fragment float4 fragmentShader(Fragment input [[stage_in]], texture2d<float> objectTexture [[texture(0)]], sampler samplerObject [[sampler(0)]], constant DirectionalLight &sun [[buffer(0)]]) {

    float3 baseColor = float3(objectTexture.sample(samplerObject, input.texcoord));

    float3 color = 0.2 * baseColor;

    float3 normal = float3(0,0,1);
    float lightAmount = max(0.0, dot(normal, -sun.forwards));
    color += lightAmount * baseColor * sun.color;

    return float4(color, 0.1);
}
