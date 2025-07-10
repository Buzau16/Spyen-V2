package window

import glfw "vendor:glfw"
import gl "vendor:OpenGL"

Window :: struct{
    width, height: i32,
    window_handle: glfw.WindowHandle
}

init :: proc(name: cstring, width, height: i32) -> Window{
    window := Window{
        width = width,
        height = height
    };

    // Load glfw
    glfw.Init();

    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 6);
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);

    window.window_handle = glfw.CreateWindow(width, height, name, nil, nil);

    glfw.MakeContextCurrent(window.window_handle);
    glfw.SetWindowUserPointer(window.window_handle, &window);

    // Load OpenGL
    gl.load_up_to(4, 6, glfw.gl_set_proc_address);

    return window;
}

poll_events :: proc() {
    glfw.PollEvents();
}

swap_buffers :: proc(window: ^Window){
    glfw.SwapBuffers(window.window_handle);
}

is_open :: proc(window: ^Window) -> bool{
    return !bool(glfw.WindowShouldClose(window.window_handle));
}

shutdown :: proc(window: ^Window){
    glfw.DestroyWindow(window.window_handle);
    glfw.Terminate();
}