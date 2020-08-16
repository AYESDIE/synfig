if(APPLE)
    # Installing Packaging related stuff
    set(OSX_RESOURCES_FILES
        ${CMAKE_SOURCE_DIR}/packaging/dmg/sif_file.icns
        ${CMAKE_SOURCE_DIR}/packaging/dmg/SynfigStudio.icns
    )
    install(FILES ${OSX_RESOURCES_FILES} DESTINATION SynfigStudio.app/Contents/Resources)

    install(FILES ${CMAKE_SOURCE_DIR}/packaging/dmg/SynfigStudio.sh
        DESTINATION SynfigStudio.app/Contents/MacOS
    )

    install(FILES ${CMAKE_SOURCE_DIR}/packaging/dmg/Info.plist
        DESTINATION SynfigStudio.app/Contents
    )

    set(OSX_PACKAGES
        atk
        atkmm
        cairo
        glib
        glibmm
        gtk+3
        gtkmm3
        imagemagick
        libxml++
        mlt
        sox
    )

    set(OSX_PREFIX "/usr/local/Cellar")
    
    foreach(OSX_PACKAGE ${OSX_PACKAGES})
        file(GLOB _OSX_PACKAGE_DIRS
            ${OSX_PREFIX}/${OSX_PACKAGE}/*/bin
            ${OSX_PREFIX}/${OSX_PACKAGE}/*/etc
            ${OSX_PREFIX}/${OSX_PACKAGE}/*/lib
            ${OSX_PREFIX}/${OSX_PACKAGE}/*/share
        )

        install(DIRECTORY ${_OSX_PACKAGE_DIRS} DESTINATION SynfigStudio.app/Contents/Resources)
    endforeach()

endif()