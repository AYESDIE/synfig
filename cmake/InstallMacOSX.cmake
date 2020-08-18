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

        set(MAC_PORT /usr/local/opt) 
        #set(APP_CONTENTS SynfigStudio.app/Contents/Resources) 
        set(OSX_RELOCATE_BINARY ${CMAKE_SOURCE_DIR}/autobuild/osx/relocate-binary.sh)
    
        set(OSX_BINARIES 
            ffmpeg/bin/ffmpeg 
            ffmpeg/bin/ffprobe 
    
            libdv/bin/encodedv 
            sox/bin/sox 
    
            gdk-pixbuf/bin/gdk-pixbuf-query-loaders 
            gdk-pixbuf/bin/gdk-pixbuf-pixdata 
            gtk+3/bin/gtk3-demo 
    
            mlt/bin/melt 
            imagemagick/bin/animate 
            imagemagick/bin/composite 
            imagemagick/bin/convert 
        ) 
    
        foreach(OSX_BINARY ${OSX_BINARIES}) 
            get_filename_component(OSX_BINARY_NAME ${MAC_PORT}/${OSX_BINARY} NAME) 
            add_custom_command( 
                OUTPUT ${SYNFIG_BUILD_ROOT}/bin/${OSX_BINARY_NAME}
                COMMAND ${OSX_RELOCATE_BINARY} ${MAC_PORT}/${OSX_BINARY} ${MAC_PORT} ${SYNFIG_BUILD_ROOT}
                DEPENDS ${MAC_PORT}/${OSX_BINARY}
            )

            list(APPEND OSX_RELOCATED_BINARIES ${SYNFIG_BUILD_ROOT}/bin/${OSX_BINARY_NAME})
            #message(${OSX_RELOCATED_BINARIES})
        endforeach()

        execute_process(
            COMMAND ls -1d ImageMagick* |head -n 1
            WORKING_DIRECTORY /
            OUTPUT_VARIABLE IMAGEMAGICK_DIR
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        message(${IMAGEMAGICK_DIR})


        file(GLOB OSX_LIBRARIES
            ${MAC_PORT}/gdk-pixbuf/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so

            ${MAC_PORT}/librsvg/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so
            ${MAC_PORT}/librsvg-2.40.20/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so

            ${MAC_PORT}/gtk+3/lib/gtk-3.0/3.0.0/immodules/*.so
            ${MAC_PORT}/gtk+3/lib/gtk-3.0/3.0.0/printbackends/*.so

            ${MAC_PORT}/cairo/lib/cairo/*.so

            ${MAC_PORT}/mlt/lib/mlt/*.so

            ${MAC_PORT}/imagemagick/lib/ImageMagick*/modules-*/coders/*.so
            ${MAC_PORT}/imagemagick/lib/ImageMagick*/modules-*/filters/*.so
        )

        file(GLOB)

        foreach(OSX_LIBRARY ${OSX_LIBRARIES}) 
            get_filename_component(OSX_LIBRARY_NAME ${OSX_LIBRARY} NAME) 
            add_custom_command( 
                OUTPUT ${SYNFIG_BUILD_ROOT}/lib/${OSX_LIBRARY_NAME}
                COMMAND ${OSX_RELOCATE_BINARY} ${OSX_LIBRARY} ${MAC_PORT} ${SYNFIG_BUILD_ROOT}
                DEPENDS ${OSX_LIBRARY}
            )

            list(APPEND OSX_RELOCATED_BINARIES ${SYNFIG_BUILD_ROOT}/lib/${OSX_LIBRARY_NAME})
            #message(${OSX_LIBRARY_NAME})
        endforeach()

        file(GLOB IMAGEMAGICK_MODULES_CODERS
            ${MAC_PORT}/imagemagick/lib/ImageMagick*/modules-*/coders/*.so
        )

        foreach(IMAGEMAGICK_MODULES_CODER ${IMAGEMAGICK_MODULES_CODERS}) 
            get_filename_component(IMAGEMAGICK_MODULES_CODER_NAME ${IMAGEMAGICK_MODULES_CODER} NAME) 
            add_custom_command( 
                OUTPUT ${SYNFIG_BUILD_ROOT}/lib/${IMAGEMAGICK_MODULES_CODER_NAME}
                COMMAND ${OSX_RELOCATE_BINARY} ${IMAGEMAGICK_MODULES_CODER} ${MAC_PORT} ${SYNFIG_BUILD_ROOT}
                DEPENDS ${IMAGEMAGICK_MODULES_CODER}
            )

            list(APPEND OSX_RELOCATED_BINARIES ${SYNFIG_BUILD_ROOT}/lib/${IMAGEMAGICK_MODULES_CODER_NAME})
            #message(${OSX_LIBRARY_NAME})
        endforeach()

        file(GLOB IMAGEMAGICK_MODULES_FILTERS
            ${MAC_PORT}/imagemagick/lib/ImageMagick*/modules-*/coders/*.so
        )

        add_custom_target(relocate_osx_binaries DEPENDS ${OSX_RELOCATED_BINARIES})
        add_dependencies(SynfigStudio relocate_osx_binaries)
    endif()
endif()