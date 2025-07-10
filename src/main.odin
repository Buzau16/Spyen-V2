package main

import "core:terminal"
import "core:fmt"
import win "window"
import gl "vendor:OpenGL"


// NOTE: Consider moving to sdl

main :: proc() {
    window := win.init("Spyen V2", 800, 450);

    for win.is_open(&window){
        win.poll_events();

        gl.ClearColor(0.2, 0.2, 0.2, 1.0);
        gl.Clear(gl.COLOR_BUFFER_BIT);
        
        win.swap_buffers(&window);
    }

}
