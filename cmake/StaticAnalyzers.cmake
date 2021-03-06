if(CLANG_TIDY)
	find_program(CLANGTIDY clang-tidy)
	if(CLANGTIDY)
		set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
		message("Clang-Tidy finished setting up.")
	else()
		message(SEND_ERROR "Clang-Tidy requested but executable not found.")
	endif()
endif()

if(CPP_CHECK)
	find_program(CPPCHECK cppcheck)
	if(CPPCHECK)
		set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude --enable=all
			--inline-suppr --inconclusive -i ${CMAKE_SOURCE_DIR}/imgui/lib)
		message("Cppcheck finished setting up.")
	else()
		message(SEND_ERROR "Cppcheck requested but executable not found.")
	endif()
endif()

if(GCC_ANALYZER)
	target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -fanalyze)
endif()