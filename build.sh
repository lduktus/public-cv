#!/usr/bin/bash

# duktus
# august 2021

# Picky bash
# -e = exit on error
# -u = unbound variables cause an error
# -o = option
set -eu

CV_DIR="./cv"
PUB_DIR="./pub"
NOW=$(date '+%Y-%m-%d')

_convert(){

    src="${1}"
    name=$(basename "${1}")
    name=${name%%.*}
    ext="html"
    format_arg="html"

    pandoc --verbose\
        --standalone\
        --template="template.${ext}"\
        --css="./style.css"\
        --metadata-file="meta.yaml"\
        --metadata=date:${NOW}\
        --from="markdown"\
        --to="${format_arg}"\
        --output="${name}.${ext}"\
        "${src}" 

    mv -v "${name}.html" "${PUB_DIR}/${name}.html"
    return 0
}

[ ! -d "$CV_DIR" ] && echo "${CV_DIR} not found." && exit 1
[ ! -d "$PUB_DIR" ] && echo "${PUB_DIR} not found." && exit 1

for f in "${CV_DIR}"/*; do
    _convert "${f}"
done
