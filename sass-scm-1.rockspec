package = "sass"
version = "scm-1"

description = {
    summary = "Lua bindings for libsass",
    homepage = "https://github.com/squeek502/lua-sass",
    license = "ISC"
}

source = {
    url = "git+https://github.com/squeek502/lua-sass.git",
    branch = "master"
}

dependencies = {
    "lua >= 5.1"
}

build = {
    type = "cmake",
    variables = {
        CMAKE_C_FLAGS="$(CFLAGS)",
        CMAKE_MODULE_LINKER_FLAGS="$(LIBFLAG)",
        LUAROCKS_INSTALL_LIBDIR="$(LIBDIR)",
    },
}
