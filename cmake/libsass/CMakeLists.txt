cmake_minimum_required (VERSION 2.6)
project (libsass CXX)

set(LIBSASS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../libsass")
set(LIBSASS_SRC_DIR "${LIBSASS_DIR}/src")
set(LIBSASS_INCLUDE_DIR "${LIBSASS_DIR}/include")

FUNCTION(PREPEND var prefix)
  SET(listVar "")
  SET(list ${${var}})
  FOREACH(f ${list})
    LIST(APPEND listVar "${prefix}/${f}")
  ENDFOREACH(f)
  SET(${var} "${listVar}" PARENT_SCOPE)
ENDFUNCTION(PREPEND)

set ( LIBSASS_SRC ast.cpp node.cpp context.cpp constants.cpp functions.cpp color_maps.cpp environment.cpp ast_fwd_decl.cpp 
  bind.cpp file.cpp util.cpp json.cpp units.cpp values.cpp plugins.cpp position.cpp lexer.cpp parser.cpp prelexer.cpp 
  eval.cpp expand.cpp listize.cpp cssize.cpp extend.cpp output.cpp inspect.cpp emitter.cpp check_nesting.cpp 
  remove_placeholders.cpp sass.cpp sass_util.cpp sass_values.cpp sass_context.cpp sass_functions.cpp sass2scss.cpp 
  to_c.cpp to_value.cpp source_map.cpp subset_map.cpp error_handling.cpp memory/SharedPtr.cpp utf8_string.cpp base64vlq.cpp )

set ( LIBSASS_CSRC cencode.c )

PREPEND( LIBSASS_SRC "${LIBSASS_SRC_DIR}" )
PREPEND( LIBSASS_CSRC "${LIBSASS_SRC_DIR}" )

add_library( libsass STATIC ${LIBSASS_SRC} ${LIBSASS_CSRC} )
target_include_directories( libsass PUBLIC ${LIBSASS_INCLUDE_DIR} )