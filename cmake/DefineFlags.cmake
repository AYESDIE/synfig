
if (CMAK)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=undefined  -fsanitize=address  -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=undefined  -fsanitize=address -fno-omit-frame-pointer")