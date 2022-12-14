# function for setting target name for build and user directory for conan

function(set_project_target_name PROJECT_ARCHITECTURE PROJECT_TARGET_NAME USER_DIRECTORY)
    string(TOLOWER ${CMAKE_SYSTEM_NAME} CMAKE_SYSTEM_NAME_LOWER)
    if(CMAKE_SYSTEM_NAME_LOWER STREQUAL "windows")
        message(STATUS "Configuring for windows")

        add_definitions(-DUNICODE)
        add_definitions(-D_UNICODE)

        set(${USER_DIRECTORY} $ENV{USERPROFILE} PARENT_SCOPE)

        if(${PROJECT_ARCHITECTURE} MATCHES "x86_64")
            set(${PROJECT_TARGET_NAME} "win64" PARENT_SCOPE)
        elseif(${PROJECT_ARCHITECTURE} MATCHES "i386")
            set(${PROJECT_TARGET_NAME} "win32" PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Invalid arch name: ${PROJECT_ARCHITECTURE}")
        endif()

    elseif(CMAKE_SYSTEM_NAME_LOWER STREQUAL "linux")
        message(STATUS "Configuring for linux")

        set(${USER_DIRECTORY} $ENV{HOME} PARENT_SCOPE)

        if(${PROJECT_ARCHITECTURE} MATCHES "x86_64")
            set(${PROJECT_TARGET_NAME} "linux64" PARENT_SCOPE)
            set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE amd64)
        elseif(${PROJECT_ARCHITECTURE} MATCHES "i386")
            set(${PROJECT_TARGET_NAME} "linux32" PARENT_SCOPE)
            set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE i386)
        elseif(${PROJECT_ARCHITECTURE} MATCHES "armv7")
            set(${PROJECT_TARGET_NAME} "linux-armhf" PARENT_SCOPE)
            set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE armhf)
        else()
            message(FATAL_ERROR "Invalid arch name: ${PROJECT_ARCHITECTURE}")
        endif()

    elseif(CMAKE_SYSTEM_NAME_LOWER STREQUAL "unix")
        message(STATUS "Configuring for unix")
        if(${PROJECT_ARCHITECTURE} MATCHES "x86_64")
            set(${PROJECT_TARGET_NAME} "unix64" PARENT_SCOPE)
        elseif(${PROJECT_ARCHITECTURE} MATCHES "i386")
            set(${PROJECT_TARGET_NAME} "unix32" PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Invalid arch name: ${PROJECT_ARCHITECTURE}")
        endif()
    endif()
endfunction()
