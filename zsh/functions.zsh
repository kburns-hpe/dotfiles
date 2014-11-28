#!/bin/zsh

# Find shortcuts
function findi() {
    find . -iname "*${1}*"
  }


# Use imagemagik to convert colors
function convertcolor() {
        convert $3 -colorspace gray -auto-level +level-colors "${1},${2}" $3
}

# Strip comments and empty lines out of a file
function catnc() {
    egrep -v '(^#|^/)' "$1" | sed '/^$/d'
}
