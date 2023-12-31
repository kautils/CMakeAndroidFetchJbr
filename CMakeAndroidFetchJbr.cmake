
macro(git_clone url)
    get_filename_component(file_name ${url} NAME)
    if(NOT EXISTS ${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name})
        file(DOWNLOAD ${url} "${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    endif()
    include("${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    unset(file_name)
endmacro()
git_clone(https://raw.githubusercontent.com/kautils/CMakeFetchZip/v0.0.1/CMakeFetchZip.cmake)


macro(CMakeAndroidFetchJbr __jbr)
    
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m ${PROJECT_NAME}.CMakeAndroidFetchJbr)
    list(APPEND ${m}_unsetter ${m}_SOURCE ${m}_DESTINATION ${m}_JBR_ID)
    
    cmake_parse_arguments(${m} "DEBUG_VERBOSE;VERBOSE;FORCE_EXTRACT;FORCE_UPDATE" "JBR_ID;SOURCE;DESTINATION" "" ${ARGV})
    
    if(NOT DEFINED ${m}_DESTINATION)
        if(NOT DEFINED KAUTIL_THIRD_PARTY_DIR)
            set(${m}_DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/CMakeAndroidFetchJbr)
        else()
            set(${m}_DESTINATION ${KAUTIL_THIRD_PARTY_DIR}/CMakeAndroidFetchJbr)
        endif()
    endif()
    
    
    if(${${m}_VERBOSE})
        set(${${m}_VERBOSE} VERBOSE)
    endif()
        
        
    if(${${m}_DEBUG_VERBOSE})
        include(CMakePrintHelpers)
        foreach(__var ${${m}_unsetter})
            cmake_print_variables(${__var})
        endforeach()
    endif()
    
    set(${__jbr}.id ${${m}_JBR_ID})
    set(${__jbr}.dir "${${m}_DESTINATION}/jbr/${${m}_JBR_ID}")
    set(${__jbr}.javac ${${__jbr}.dir}/bin/javac.exe)
    set(${__jbr}.jar ${${__jbr}.dir}/bin/jar.exe)
    
    
    if(NOT EXISTS ${${__jbr}.dir})
        CMakeFetchZip(
            SOURCE  ${${m}_SOURCE}
            DESTINATION ${${__jbr}.dir}
            WORKING_DIRECTORY ${${m}_DESTINATION}/download
            ${${m}_VERBOSE}
            FORCE_EXTRACT
        )
        if(EXISTS ${${__jbr}.dir})
            file(REMOVE_RECURSE ${${__jbr}.dir}.buf)
            file(RENAME ${${__jbr}.dir} ${${__jbr}.dir}.buf)
            file(GLOB ${m}_res ${${__jbr}.dir}.buf/*)
            foreach(${m}_var ${${m}_res})
                file(RENAME ${${m}_var} ${${__jbr}.dir})
                break()
            endforeach()
            file(REMOVE_RECURSE ${${__jbr}.dir}.buf)
        endif()
    endif()
    
    if(NOT EXISTS ${${__jbr}.dir})
        message(FATAL_ERROR "jbr was not found. may be fail to fetch : ${${__jbr}.dir}")
    endif()
    if(NOT EXISTS ${${__jbr}.javac})
        message(FATAL_ERROR "javac was not found. may be fail to fetch : ${${__jbr}.dir}")
    endif()
    
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
endmacro()
