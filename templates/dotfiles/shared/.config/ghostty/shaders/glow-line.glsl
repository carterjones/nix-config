// glow-line.glsl
// A radar-style sweep: a bright leading edge that slowly travels across the
// screen, with a long soft tail fading out behind it. Reminiscent of
// cool-retro-term's "Glow Line", but shaped like a radar tail. No jitter.
//
// Ghostty runs shaders in Shadertoy format:
//   iChannel0   - the rendered terminal
//   iTime       - seconds since start (needs custom-shader-animation = true)
//   iResolution - viewport size in pixels
//
// Tunables:
//   SPEED        - screens per second the sweep travels (lower = slower)
//   HEAD         - thin glow ahead of the leading edge (normalized height)
//   TAIL_LENGTH  - how far the tail fades behind the leading edge
//   TAIL_FALLOFF - >1 concentrates brightness near the leading edge
//   INTENSITY    - brightness added at the leading edge
//   TINT         - color of the glow (RGB, 0..1)
//   TAIL_DIR     - flip to -1.0 if the tail ends up on the wrong side

const float SPEED        = 0.06;
const float HEAD         = 0.004;
const float TAIL_LENGTH  = 0.16;
const float TAIL_FALLOFF = 2.5;
const float INTENSITY    = 0.08;
const vec3  TINT         = vec3(0.62, 0.70, 0.82);
const float TAIL_DIR     = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Base terminal image.
    vec4 base = texture(iChannel0, uv);

    // Leading-edge position of the sweep.
    float linePos = fract(iTime * SPEED);

    // Signed, wrapped distance from this row to the leading edge.
    // Negative = behind the sweep (tail side), positive = ahead of it.
    float s = fract(uv.y - linePos + 0.5) - 0.5;
    s *= TAIL_DIR;

    float b;
    if (s > 0.0) {
        // Thin glow just ahead of the leading edge.
        b = 1.0 - smoothstep(0.0, HEAD, s);
    } else {
        // Long tail: brightest at the leading edge, fading out behind.
        float t = smoothstep(-TAIL_LENGTH, 0.0, s);
        b = pow(t, TAIL_FALLOFF);
    }

    vec3 glow = TINT * b * INTENSITY;

    fragColor = vec4(base.rgb + glow, base.a);
}
