[![ANGLE Cover](cover.jpg)](https://github.com/indiesoftby/defold-graphics-angle)

# ANGLE for Defold (Preview)

Add this extension to your project so that your Defold game on Windows runs through DirectX 9 or 11, has high compatibility with legacy devices and video drivers, since DirectX is a first-party API unlike OpenGL.

## Description

This is a native extension for Defold that replaces the OpenGL graphics adapter with OpenGL ES via [Google ANGLE](https://chromium.googlesource.com/angle/angle). ANGLE translates OpenGL ES API calls to one of the hardware-supported APIs available for that platform. ANGLE supports various graphics APIs, including DirectX 9, 11, and OpenGL, and includes workarounds for problematic GPUs, which broadens your game's compatibility with legacy devices or GPUs with problematic drivers.

Supported operating system: **Windows**.

Reasons to use this native extension in your projects:
* The Defold engine pegs one CPU core at 100% without good reason.
* An empty project does not deliver a stable 60 FPS on a 60 Hz monitor.
* Your GPU does not support OpenGL 3.3 but does support Direct3D 9 like good old Intel GMA 950.
* Your game crashes due to use RivaTuner Statistics Server (usually comes with MSI Afterburner).
* You are planning to release a game on Steam/itch.io/GOG, etc., and want fewer issues running on older devices or devices with problematic graphics drivers.

## How to use it

1) Add the extension zip file as dependency to your project from [the release page](https://github.com/indiesoftby/defold-graphics-angle/releases/tag/1.0.0).
2) Open your `game.project` file in any external text editor and add the following lines to end of the file (example: [game.project](extension/game.project)):
```ini
[shader]
output_glsl_es100 = 1
output_glsl_es300 = 1
```

If you did everything correctly, then after launching your game you will see in the logs:
```
INFO:GRAPHICS: Installed graphics device 'ADAPTER_FAMILY_OPENGLES'
```

If you enable the `Display / Display Device Info` option in `game.project`, you will see something like this:
```
INFO:GRAPHICS: Device: OpenGL ES
INFO:GRAPHICS: Renderer: ANGLE (Intel, Intel(R) Arc(TM) B580 Graphics (0x0000E20B) Direct3D11 vs_5_0 ps_5_0, D3D11-32.0.101.6913)
INFO:GRAPHICS: Version: OpenGL ES 3.0.0 (ANGLE <version> <hash>)
INFO:GRAPHICS: Vendor: Google Inc. (Intel)
INFO:GRAPHICS: Extensions:
INFO:GRAPHICS:   GL_AMD_performance_monitor
INFO:GRAPHICS:   GL_ANGLE_base_vertex_base_instance_shader_builtin
INFO:GRAPHICS:   GL_ANGLE_blob_cache
...
```

If you are facing problems with the extension, please check the [Known limitations or incompatibility issues](#known-limitations-or-incompatibility-issues) section and fill an issue.

### Known limitations or incompatibility issues

#### Excluding GL ES 1.00 shader language

The configuration above ensures maximum GPU compatibility by generating shaders for both GL ES 1.00 and GL ES 3.00 shader languages, covering support for OpenGL ES 2.0 and 3.0 for the widest range of graphics hardware. If you want to exclude GL ES version 1.00 shaders, you should remove the `output_glsl_es100` line from `game.project` and add the line:

```ini
[shader]
exclude_gles_sm100 = 1
output_glsl_es300 = 1
```

#### [Dear ImGUI](https://github.com/britzl/extension-imgui)

Dear ImGUI is not compatible with ANGLE, because it assumes that the graphics adapter is OpenGL. The workaround is:

1) Copy the `imgui` folder from the extension to your project.
2) Modify the `imgui/src/imgui/imconfig.h` file:
```c
#pragma once

#if defined(DM_PLATFORM_HTML5) or defined(USE_GLES2)
  #define IMGUI_IMPL_OPENGL_ES2

// etc...
```
3) Modify the `imgui/ext.manifest` file:
```
    win32:
        context:
            defines:    ["STBI_NO_SIMD", "USE_GLES2"]
```

## How it is implemented

TODO

## License

ANGLE binaries are distributed under the BSD-3 license; see the [`ANGLE_LICENSE.txt`](extension/graphics_angle/ANGLE_LICENSE.txt) file.

This repository is distributed under the CC0 license; see the [`LICENSE.md`](LICENSE.md) file.
