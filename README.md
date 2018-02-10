lua-sass
========

This fork is mostly unchanged from [craigbarnes/lua-sass](https://github.com/craigbarnes/lua-sass) except that it uses CMake for compilation and therefore gets Windows support for free.

[![Build status](https://ci.appveyor.com/api/projects/status/30hr58dq6c9tsgi5?svg=true)](https://ci.appveyor.com/project/squeek502/lua-sass)
[![Build Status](https://travis-ci.org/squeek502/lua-sass.svg?branch=master)](https://travis-ci.org/squeek502/lua-sass)

Lua bindings for [libsass].

Requirements
------------

* C compiler
* [CMake]
* [Lua] or [LuaJIT]

Installation
------------

First, clone this repository, making sure to initialize the submodule (`git submodule update --init`).

### On Windows
Open a command line in the `lua-sass` directory and do the following:
```sh
mkdir build
cd build
cmake ..
cmake --build . --config Release --target install
```
If needed, you can specify a [generator](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html) by doing `cmake -G "Visual Studio 14 2015 Win64" ..` instead of `cmake ..`

*Note: On Windows, you'll need to have a Lua static library available that [can be found by `cmake`](https://cmake.org/cmake/help/v3.0/module/FindLua.html) (preferably built with the same compiler you're using to build `lua-sass`).*

### On Linux
From the `lua-sass` directory, do the following:
```sh
mkdir build && cd build
cmake ..
make
make install
```

### Building against a shared libsass
By default, libsass will be built and linked statically. However, the CMake option `WITH_SHARED_LIBSASS` can be turned on to build against an existing shared library of libsass. Note: this has only been tested on Windows so far.

Usage
-----

The `sass` module provides 2 functions, which are named in accordance with
their [libsass] counterparts:

### compile

    local css, err = sass.compile(scss, style)

**Parameters:**

1. `scss`: A string of [SCSS] input text.
2. `style`: The output style. Either `"nested"`or `"compressed"`
   (*optional*; defaults to `"nested"`).

**Returns:**

Either a string of CSS on success, or `nil` and an error message on failure.

### compile_file

    local css, err = sass.compile_file(filename, style)

**Parameters:**

1. `filename`: An [SCSS] file to read input from.
2. As above.

**Returns:**

As above.

Examples
--------

Compiling a string and using the `assert` idiom for error handling:

```lua
local sass = require "sass"
local css = assert(sass.compile "$x: red; div {color: $x}")
print(css)
```

Compiling a file and using explicit error handling:

```lua
local sass = require "sass"
local css, err = sass.compile_file("file.scss", "nested")
if css then
    print(css)
else
    io.stderr:write("Error: ", err, "\n")
end
```


[libsass]: https://github.com/hcatlin/libsass
[CMake]: https://cmake.org/
[Lua]: http://www.lua.org/
[LuaJIT]: http://luajit.org/
[SCSS]: http://sass-lang.com/documentation/file.SASS_REFERENCE.html#syntax
