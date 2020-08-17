if(APPLE && INSTALL_MACOSX_PORTABLE)
    add_executable(SynfigStudio MACOSX_BUNDLE ${CMAKE_SOURCE_DIR}/autobuild/osx/synfig_osx_launcher.cpp)

    # Copy the entire template folder in there.
    install(
        DIRECTORIES ${CMAKE_SOURCE_DIR}/autobuild/osx/app-template/Contents
        DESTINATION SynfigStudio.app
    )

    set(MAC_PORT "/usr/local/opt")
    set(APP_CONTENTS SynfigStudio.app/Contents/Resources)

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

        install(
            FILES ${MAC_PORT}/${OSX_BINARY}
            DESTINATION ${APP_CONTENTS}/bin
        )
    endforeach()
endif()