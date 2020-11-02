# Get git short SHA
FIND_PACKAGE(Git REQUIRED)
IF(EXISTS "${CMAKE_SOURCE_DIR}/.git")
	EXECUTE_PROCESS(COMMAND git rev-parse --short HEAD
		RESULT_VARIABLE GIT_SHA_RESULT
		OUTPUT_VARIABLE GIT_SHA)
	IF(GIT_SHA_RESULT EQUAL "1")
		MESSAGE(FATAL_ERROR
			"git rev-parse --short HEAD failed; unable to generate ck_md.h.")
	ELSE()
		# Strip trailing newline
		STRING(REGEX REPLACE "\n$" "" GIT_SHA "${GIT_SHA}")
		MESSAGE(STATUS "Got git short hash ${GIT_SHA}.")
	ENDIF()
ELSE()
	MESSAGE(FATAL_ERROR "Git not found.")
ENDIF()

# Header contains git short SHA
CONFIGURE_FILE(
	${CMAKE_SOURCE_DIR}/src/version.hxx.in
	${CMAKE_SOURCE_DIR}/src/version.hxx)