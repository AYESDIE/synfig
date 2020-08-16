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

    set(OSX_COPY_DIRS
        bin
        etc
        lib
        share
    )

    set(OSX_PACKAGES
        imagemagick
        libxml++
        mlt
        sox
    )

    set(OSX_PREFIX "/usr/local/opt")
    
    foreach(OSX_PACKAGE ${OSX_PACKAGES})
        foreach(OSX_COPY_DIR ${OSX_COPY_DIRS})
            file(GLOB _OSX_PACKAGE_DIR
                ${OSX_PREFIX}/${OSX_PACKAGE}/${OSX_COPY_DIR}
            )

            install(DIRECTORY ${_OSX_PACKAGE_DIR} DESTINATION SynfigStudio.app/Contents/Resources)
        endforeach()
    endforeach()

endif()