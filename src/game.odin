package main

import rl "vendor:raylib"

TileMap :: struct{
    rows: i32,
    cols: i32,
    tiles: [dynamic]Tile
}

tilemap_add :: proc(tile: Tile){
    append(&tile_map.tiles, tile)
}

tilemap_render :: proc(){
    for tile in tile_map.tiles{
        rl.DrawTexture(tile.texture, tile.pos.x, tile.pos.y, rl.RAYWHITE)
    }
}

Tile :: struct{
    pos: [2]i32,
    texture: rl.Texture2D
}

create_tile :: proc(pos: [2]i32, texturepath: cstring) -> Tile{
    return Tile{
        pos = pos,
        texture = rl.LoadTexture(texturepath)
    }
}

GameManager :: struct{
    player: ^Player,
    tile_map: ^TileMap
}

manager_update :: proc(dt: f64){
    player_update(dt)
    tilemap_render()
}

manager_render :: proc(){
    player_render()
}

manager_shutdown :: proc(){
    player_destroy()
    for tile, i in manager.tile_map.tiles{
        rl.UnloadTexture(tile.texture)
        unordered_remove(&manager.tile_map.tiles, i)
    }

}