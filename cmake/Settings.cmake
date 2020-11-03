option(VCPKG "Enable vcpkg" ON)
option(CCACHE "Enable the usage of Ccache, in order to speed up rebuild times." ON)

if(CMAKE_BUILD_TYPE MATCHES DEBUG)
	option(VERBOSE "Verbose output" ON)
	option(CLANG_TIDY "Enable clang-tidy" ON)
	option(CPP_CHECK "Enable cppcheck" ON)
	if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		option(GCC_ANALYZER "GCC -fanalyze" ON)
	else()
		option(GCC_ANALYZER "GCC -fanalyze" OFF)
	endif()
	option(ENABLE_LTO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)." OFF)
else()
	option(VERBOSE "Verbose output" OFF)
	option(CLANG_TIDY "Enable clang-tidy" OFF)
	option(CPP_CHECK "Enable cppcheck" OFF)
	option(GCC_ANALYZER "GCC -fanalyze" OFF)
	option(ENABLE_LTO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)." ON)
endif()

if(ENABLE_LTO)
	include(CheckIPOSupported)
	check_ipo_supported(RESULT result OUTPUT output)
	if(result)
		set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	else()
		message(SEND_ERROR "IPO is not supported: ${output}.")
	endif()
endif()

if(CCACHE)
	find_program(CCACHE_FOUND ccache)
	if(CCACHE_FOUND)
		set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
		set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
	endif()
endif()