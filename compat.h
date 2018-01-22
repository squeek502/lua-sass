#if !defined(_WIN32)
#if !defined(__STDC_VERSION__) || !(__STDC_VERSION__ >= 199901L)
# error C99 compiler required.
#endif
#endif

#ifndef LUA_VERSION_NUM
# error Lua >= 5.1 is required.
#endif

#if LUA_VERSION_NUM < 502
# define luaL_newlib(L, l) (lua_newtable(L), luaL_register(L, NULL, l))
#endif

#ifdef _WIN32
# define EXPORT __declspec(dllexport)
#else
# define EXPORT
#endif
