package main

import "core:terminal"
import "core:fmt"
import rl "vendor:raylib"

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 450

player : Player
manager : GameManager
tile_map : TileMap

// TODO: for each tilemap_add() call a new texture is loaded. Consider caching some of those textures for maybe faster loading

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE})
    rl.InitWindow(800, 450, "COX")
    defer rl.CloseWindow()

    player = player_create({0, 0}, "assets/textures/Player.png")
    defer player_destroy()

    manager = GameManager{
        player = &player,
        tile_map = &tile_map
    }
    defer manager_shutdown()

    for y in 0..=25{
        for x in 0..=25{
            offset := [2]i32{
                i32(x * 32),
                i32(y * 32)
            }
            tilemap_add(create_tile(offset, "assets/textures/Tile.png"))
        }
    }

    deltatime : f64
    now : f64
    prev := rl.GetTime()

    rl.SetTargetFPS(400)

    for !rl.WindowShouldClose(){

        now = rl.GetTime()
        deltatime = now - prev
        prev = now

        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)

        manager_update(deltatime)
        manager_render()

        rl.DrawText(rl.TextFormat("CURRENT FPS: %i", rl.GetFPS()), rl.GetScreenWidth() - 220, 40, 20, rl.RED);

        

        rl.EndDrawing()
    }
}
