package main

import rl "vendor:raylib"
import "core:math/rand"

Particle :: struct {
    pos: [2]f32,
    vel: [2]f32
}

main :: proc() {
    width := 1280
    height := 720
    rl.InitWindow(1280, 720, "Particles")
    defer rl.CloseWindow()

    particles: [dynamic]^Particle

    for i := 0; i < 100_000; i += 1 {
        p := new(Particle)
        p^ = Particle{{rand.float32() * f32(width), rand.float32() * f32(height)}, {0, 0}}
        append(&particles, p)
    }

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {

        for p in particles {
            if rl.IsMouseButtonDown(rl.MouseButton.LEFT) {
                p^.vel += (rl.GetMousePosition() - p^.pos) / (4 * rl.Vector2Distance(rl.GetMousePosition(), p^.pos))
            } else {
                p^.vel = p^.vel * 0.99
            }
            p^.pos += p^.vel
        }

        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        for p in particles {
            rl.DrawPixelV(p^.pos, rl.BLACK)
        }
        rl.DrawFPS(10, 10)
        rl.EndDrawing()
    }
}