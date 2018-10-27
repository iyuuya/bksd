#!/bin/sh

cd ag && ./build.sh && cd - &
cd git && ./build.sh && cd - &
cd gotoolpack && ./build.sh && cd - &
cd nvim && ./build.sh && cd - &
cd tig && ./build.sh && cd - &
cd tmux && ./build.sh && cd - &
wait

cd base && ./build.sh && cd -
