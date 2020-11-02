#add_subdirectory()

target_sources(denanc PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/main.cxx"
)

target_include_directories(denanc PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
