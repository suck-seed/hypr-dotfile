#version 320 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform vec2 screenSize;
out vec4 fragColor;

// Pixel radius for rounded corners
const float radiusPx = 12.0;
// Anti-alias width in pixels (higher = softer edge)
const float feather = 1.5;

void main() {
    vec2 uv = v_texcoord;
    vec2 res = screenSize;

    vec4 col = texture(tex, uv);

    // UV -> pixel space
    vec2 pos = uv * res;

    // Circle centers
    vec2 cBL = vec2(radiusPx, radiusPx);
    vec2 cTL = vec2(radiusPx, res.y - radiusPx);
    vec2 cBR = vec2(res.x - radiusPx, radiusPx);
    vec2 cTR = vec2(res.x - radiusPx, res.y - radiusPx);

    // Distances to centers
    float dBL = distance(pos, cBL);
    float dTL = distance(pos, cTL);
    float dBR = distance(pos, cBR);
    float dTR = distance(pos, cTR);

    // Corner squares
    bool inBL = (pos.x < radiusPx && pos.y < radiusPx);
    bool inTL = (pos.x < radiusPx && pos.y > res.y - radiusPx);
    bool inBR = (pos.x > res.x - radiusPx && pos.y < radiusPx);
    bool inTR = (pos.x > res.x - radiusPx && pos.y > res.y - radiusPx);

    bool inAnyCorner = inBL || inTL || inBR || inTR;

    // If we're not anywhere near a corner, draw the normal image, no tint
    if (!inAnyCorner) {
        fragColor = col;
        return;
    }

    // edge > 0  = inside the circle
    // edge = 0  = exactly on the circle
    // edge < 0  = outside the circle
    float edge = -1.0;
    if (inBL) edge = radiusPx - dBL;
    if (inTL) edge = radiusPx - dTL;
    if (inBR) edge = radiusPx - dBR;
    if (inTR) edge = radiusPx - dTR;

    // Smooth alpha across [-feather, +feather]
    float alpha = smoothstep(-feather, feather, edge);

    // Outside color (cutout)
    vec4 mask = vec4(0.0, 0.0, 0.0, 1.0);

    fragColor = mix(mask, col, alpha);
}
