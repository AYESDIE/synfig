function(synfig_install)
    set(_files FILES)
    set(_destination DESTINATION)
    set(_targets TARGETS)

    cmake_parse_arguments(
        _parsedArguments
        ""
        "${_destination}"
        "${_files};${_targets}"
        ${ARGN}
    )

    if(_parsedArguments_FILES)
        if(APPLE)
            install(FILES ${_parsedArguments_FILES}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        else()
            install(FILES ${_parsedArguments_FILES}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        endif()
    elseif(_parsedArguments_TARGETS)
        if(APPLE)
            install(TARGETS ${_parsedArguments_TARGETS}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        else()
            install(TARGETS ${_parsedArguments_TARGETS}
                DESTINATION ${_parsedArguments_DESTINATION}
            )
        endif()
    endif()

endfunction()