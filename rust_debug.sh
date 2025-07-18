#!/bin/bash

clear
cd rust
cargo clean

first_compile_start=$(date +%s.%N)
cargo build
first_compile_end=$(date +%s.%N)

second_compile_start=$(date +%s.%N)
cargo build
second_compile_end=$(date +%s.%N)

third_compile_start=$(date +%s.%N)
cargo build
third_compile_end=$(date +%s.%N)

fourth_compile_start=$(date +%s.%N)
cargo build
fourth_compile_end=$(date +%s.%N)

cd ..

first_compile=$(awk "BEGIN {print $first_compile_end - $first_compile_start}")
second_compile=$(awk "BEGIN {print $second_compile_end - $second_compile_start}")
third_compile=$(awk "BEGIN {print $third_compile_end - $third_compile_start}")
fourth_compile=$(awk "BEGIN {print $fourth_compile_end - $fourth_compile_start}")

echo "Time needed for first compile: $first_compile s"
echo "Time needed for next compiles after initial compile:"
echo "$second_compile s"
echo "$third_compile s"
echo "$fourth_compile s"
