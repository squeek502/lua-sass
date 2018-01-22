cmake_minimum_required (VERSION 3.1)
project (luasass C)

option(WITH_SHARED_LIBSASS "Link to a shared libsass library instead of static linking" OFF)

if(UNIX)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

if(WIN32)
  find_package (Lua REQUIRED)
else()
  # Only the include dir matters on UNIX
  find_package (Lua)
  if(NOT LUA_INCLUDE_DIR)
    message( FATAL_ERROR "Variable `LUA_INCLUDE_DIR' expected to be defined.")
  endif()
endif()
include_directories(${LUA_INCLUDE_DIR})

# libsass
if (WITH_SHARED_LIBSASS)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
  find_package(Libsass REQUIRED)
else ()
  add_subdirectory(cmake/libsass)
  set(LIBSASS_LIBRARIES libsass)
endif ()

# lua-sass
add_library( luasass MODULE sass.c )
target_link_libraries ( luasass ${LIBSASS_LIBRARIES} )
target_include_directories ( luasass PRIVATE ${LIBSASS_INCLUDE_DIR} )
set_target_properties( luasass PROPERTIES PREFIX "" OUTPUT_NAME "sass" )
set_property( TARGET luasass PROPERTY C_STANDARD 99 )
if(WIN32)
  target_compile_definitions(luasass PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()

# Only link against the Lua library on Windows
if(WIN32)
  target_link_libraries ( luasass ${LUA_LIBRARIES} )
endif()

# Needed to avoid getting undefined references to liblua
if(APPLE)
  set(CMAKE_SHARED_MODULE_CREATE_C_FLAGS "${CMAKE_SHARED_MODULE_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

# Build static library when cross-compiling
if(WIN32 AND CMAKE_HOST_UNIX)
  add_library( libluasass STATIC sass.c )
  target_link_libraries ( libluasass ${LUA_LIBRARIES} libmarkdown )
  target_include_directories ( libluasass PRIVATE ${LIBSASS_INCLUDE_DIR} )
  set_target_properties ( libluasass PROPERTIES OUTPUT_NAME luasass )
  set_property( TARGET libluasass PROPERTY C_STANDARD 99 )
  if(WIN32)
    target_compile_definitions(libluasass PRIVATE _CRT_SECURE_NO_WARNINGS)
  endif()
endif()

# Install targets for Luarocks and non-Luarocks
if(LUAROCKS_INSTALL_LIBDIR)
  SET(INSTALL_LIB_DIR ${LUAROCKS_INSTALL_LIBDIR})
elseif(UNIX)
  set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}")
elseif(WIN32)
  set(INSTALL_LIB_DIR "${PROJECT_SOURCE_DIR}")
endif()

if(INSTALL_LIB_DIR)
  install(TARGETS luasass ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" LIBRARY DESTINATION "${INSTALL_LIB_DIR}")
endif()