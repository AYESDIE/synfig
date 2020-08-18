if(APPLE)
    if(${MACOSX_PACKAGE})
        # Copy App Template
        file(
            COPY ${CMAKE_SOURCE_DIR}/autobuild/osx/app-template/Contents 
            DESTINATION ${CMAKE_BINARY_DIR}/output/SynfigStudio.app
        )

        add_executable(SynfigStudio ${CMAKE_SOURCE_DIR}/autobuild/osx/synfig_osx_launcher.cpp)
        set_target_properties(SynfigStudio
            PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output/SynfigStudio.app/Contents/MacOS
        )

        file(GLOB OSX_BINARY
            
        
        )
    endif()
endif()