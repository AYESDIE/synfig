function(synfig_install)
    set(_files FILES)    
    set(_targets TARGETS)
    set(_destination DESTINATION)

    cmake_parse_arguments(
        _parsedArguments
        ""
        "${_destination}"
        "${_files};${_targets}"
        ${ARGN}
    )

    if(_parsedArguments_FILES)
        if(APPLE AND INSTALL_MACOSX_PORTABLE)
            install(FILES ${_parsedArguments_FILES}
                DESTINATION SynfigStudio.app/Contents/Resources/${_parsedArguments_DESTINATION}
            )
        else()
            install(FILES ${_parsedArguments_FILES}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        endif()
    elseif(_parsedArguments_TARGETS)
        if(APPLE AND INSTALL_MACOSX_PORTABLE)
            install(TARGETS ${_parsedArguments_TARGETS}
                DESTINATION SynfigStudio.app/Contents/Resources/${_parsedArguments_DESTINATION}
            )
        else()
            install(TARGETS ${_parsedArguments_TARGETS}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        endif()
    endif()

endfunction()