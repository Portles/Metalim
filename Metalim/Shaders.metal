//
//  Shaders.metal
//  Metalim
//
//  Created by Nizamet Özkan on 6.12.2023.
//

#include <metal_stdlib>
using namespace metal;

#include "definitions.h"

struct Fragment {
    float4 position [[position]];
    float4 color;
};

vertex Fragment vertexShader(const device Vertex *vertextArray [[buffer(0)]], unsigned int vid [[vertex_id]], constant matrix_float4x4 &model [[buffer(1)]]) {
    Vertex input = vertextArray[vid];

    Fragment output;
    output.position = model * float4(input.position.x, input.position.y, input.position.z, 1);
    output.color = input.color;

    return output;
}

fragment float4 fragmentShader(Fragment input [[stage_in]]) {
    return input.color;
}
