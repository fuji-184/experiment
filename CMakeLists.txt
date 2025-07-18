cmake_minimum_required(VERSION 3.20)
project(HelloStaticCXX23)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

add_executable(hello main.cpp)

include(CheckIPOSupported)
check_ipo_supported(RESULT ipo_supported OUTPUT ipo_error)
if(ipo_supported)
    set_property(TARGET hello PROPERTY INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE)
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        target_compile_options(hello PRIVATE
            -O3
            -fno-rtti
            -fno-exceptions
            -fstrict-overflow
            -fno-stack-protector)
        target_link_options(hello PRIVATE
            -static-libstdc++
            -static-libgcc
            -Wl,-O1,--as-needed,--gc-sections)
    else()
        target_compile_options(hello PRIVATE -g)
        target_link_options(hello PRIVATE -static-libstdc++ -static-libgcc)
    endif()
endif()

set_target_properties(hello PROPERTIES LINK_WHAT_YOU_USE TRUE)
