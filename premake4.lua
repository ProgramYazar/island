
local action = _ACTION or ""

solution "island"
    location (".project")
    configurations { "Debug", "Release" }
    platforms {"native", "x64", "x32"}
    language "C"

    configuration "vs*"
        defines { "_CRT_SECURE_NO_WARNINGS" }

    configuration "Debug"
        targetdir ("bin/Debug")
        defines { "DEBUG" }
        flags { "Symbols"}

    configuration "Release"
        targetdir ("bin/Release")
        defines { "NDEBUG" }
        flags { "Optimize"}

    project "glfw"
        kind "StaticLib"
        includedirs { "3rdparty/glfw/include" }
        files { 
            "3rdparty/glfw/src/clipboard.c",
            "3rdparty/glfw/src/context.c",
            "3rdparty/glfw/src/gamma.c",
            "3rdparty/glfw/src/init.c",
            "3rdparty/glfw/src/input.c",
            "3rdparty/glfw/src/joystick.c",
            "3rdparty/glfw/src/monitor.c",
            "3rdparty/glfw/src/time.c",
            "3rdparty/glfw/src/window.c",
            "3rdparty/glfw/src/input.c",
            "3rdparty/glfw/src/input.c",
        }

        defines { "_GLFW_USE_OPENGL" }

        configuration "windows"
            defines { "_GLFW_WIN32", "_GLFW_WGL" }
            files {
                "3rdparty/glfw/src/win32*.c",
                "3rdparty/glfw/src/wgl_context.c",
                "3rdparty/glfw/src/winmm_joystick.c",
            }

    project "glew"
        kind "StaticLib"
        includedirs { "3rdparty/glew" }
        files { "3rdparty/glew/*.c" }
        defines "GLEW_STATIC"

    project "nanovg"
        kind "StaticLib"
        includedirs { "3rdparty/nanovg/src" }
        files { "3rdparty/nanovg/src/*.c" }

    project "libuv"
        kind "StaticLib"
        includedirs { "3rdparty/libuv/include" }
        files { 
            "3rdparty/libuv/src/*.c", 
            "3rdparty/libuv/src/win/*.c" 
        }

    project "lua"
        os.copyfile("3rdparty/lua/src/luaconf.h.orig", "3rdparty/lua/src/luaconf.h")
        kind "StaticLib"
        includedirs { "3rdparty/lua/src" }
        files { "3rdparty/lua/src/*.c"}
        excludes {
            "3rdparty/lua/src/loadlib_rel.c",
            "3rdparty/lua/src/lua.c",
            "3rdparty/lua/src/luac.c",
            "3rdparty/lua/src/print.c",
        }

    function create_example_project( example_path )
        example_path = string.sub(example_path, string.len("examples/") + 1);
        project (example_path)
            kind "ConsoleApp"
            files { "examples/" .. example_path .. "/*.c" }
            defines { "GLEW_STATIC" }
            includedirs { 
                "3rdparty",
                "3rdparty/glfw/include",
                "3rdparty/glew",
                "3rdparty/nanovg/src",
                "3rdparty/libuv/src",
                "3rdparty/lua/src",
                "3rdparty/stb"
            }
            links {
                "glew",
                "glfw",
                "libuv",
                "nanovg",
                "lua",
            }

            configuration "windows"
                links {
                    "OpenGL32"
                }
    end

    local examples = os.matchdirs("examples/*")
    for _, example in ipairs(examples) do
        create_example_project(example)
    end

