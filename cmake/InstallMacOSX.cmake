if(APPLE && INSTALL_MACOSX_PORTABLE)
    add_executable(SynfigStudio MACOSX_BUNDLE ${CMAKE_SOURCE_DIR}/autobuild/osx/synfig_osx_launcher.cpp)

    install(
        FILES SynfigStudioa.app
        DESTINATION .
    )

    # Copy the entire template folder in there.
    install(
        DIRECTORIES ${CMAKE_SOURCE_DIR}/autobuild/osx/app-template/Contents
        DESTINATION SynfigStudio.app
    )

    set(MAC_PORT "/usr/local/opt")
    set(APP_CONTENTS "\${CMAKE_INSTALL_PREFIX}/SynfigStudio.app/Contents/Resources")

    set(OSX_BINARIES
        /ffmpeg/bin/ffmpeg
        /ffmpeg/bin/ffprobe

        /libdv/bin/encodedv
        /sox/bin/sox

        /gdk-pixbuf/bin/gdk-pixbuf-query-loaders
        /gdk-pixbuf/bin/gdk-pixbuf-pixdata
        /gtk+3/bin/gtk3-demo

        /bin/melt
        /imagemagick/bin/animate
        /imagemagick/bin/composite
        /imagemagick/bin/convert
    )

    foreach(OSX_BINARY ${OSX_BINARIES})
        get_filename_component(OSX_BINARY_NAME ${MAC_PORT}/${OSX_BINARY} NAME)
        #add_custom_command(
        #    OUTPUT 
        #)

        add_custom_command(
            OUTPUT ${APP_CONTENTS}/bin/${OSX_BINARY_NAME}
            COMMAND ${CMAKE_SOURCE_DIR}/autobuild/osx/relocate-binary.sh ${MAC_PORT}/${OSX_BINARY} ${MAC_PORT} ${APP_CONTENTS}
        )

        list(APPEND OSX_BINARIES_LIST ${APP_CONTENTS}/bin/${OSX_BINARY_NAME})
    endforeach()
    
    add_custom_target(fixed_macosx_binary DEPENDS ${OSX_BINARIES_LIST})
    add_dependency(SynfigStudio fixed_macosx_binary)

endif()