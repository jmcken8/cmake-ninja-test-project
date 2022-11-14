#!/bin/bash

mkdir -p generated
touch generated/CMakeLists.txt
for i in {1..10000}; do
    touch generated/file${i}.cpp
    cat << EOF >> generated/CMakeLists.txt
add_whole_library(l${i} file${i}.cpp)
target_link_libraries(ex l${i})

EOF
done
