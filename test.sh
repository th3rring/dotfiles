#!/bin/bash

test () {
echo "This is a function"
}

call_func () {
$1
}

call_func test
