#set(Boost_USE_STATIC_LIBS ON)
#set(Boost_USE_STATIC_RUNTIME ON)
#find_package(Boost REQUIRED COMPONENTS filesystem)
#if(Boost_FOUND)
#	target_include_directories(denanc PRIVATE ${Boost_INCLUDE_DIRS})
#	target_link_libraries(denanc ${Boost_LIBRARIES})
#endif()
#add_compile_definitions(BOOST_STACKTRACE_USE_ADDR2LINE)

# Abseil
#find_package(absl CONFIG REQUIRED)
#target_link_libraries(denanc absl::flat_hash_map)

target_include_directories(project PUBLIC "${CMAKE_CURRENT_SOURCE_DIR"})
