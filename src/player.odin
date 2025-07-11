package main

import rl "vendor:raylib"

Player :: struct{
    pos: rl.Vector2,
    texture: rl.Texture2D
}

player_create :: proc(pos: rl.Vector2, texturepath: cstring) -> Player{
    return Player{
        pos = pos,
        texture = rl.LoadTexture(texturepath),
    }
}

player_render :: proc(){
    rl.DrawTexture(player.texture, i32(player.pos.x), i32(player.pos.y), rl.WHITE)
}

player_destroy :: proc(){
    rl.UnloadTexture(player.texture)
}

player_update :: proc(dt: f64){
    if rl.IsKeyDown(rl.KeyboardKey.D){
        player.pos.x += f32(160 * dt)
    }
    if rl.IsKeyDown(rl.KeyboardKey.A){
        player.pos.x -= f32(160 * dt)
    }
    if rl.IsKeyDown(rl.KeyboardKey.W){
        player.pos.y -= f32(160 * dt)
    }
    if rl.IsKeyDown(rl.KeyboardKey.S){
        player.pos.y += f32(160 * dt)
    }
}
