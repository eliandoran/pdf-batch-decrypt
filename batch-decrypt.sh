#!/bin/bash
PATTERN=$1
INPUT_DIR=`realpath $2`
OUTPUT_DIR=$3
CUR_DIR=`pwd | xargs realpath`

cd $INPUT_DIR
FILES=`find . -name "*.pdf"`
IFS=$'\n'

cd $CUR_DIR
rm -r $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

for FILE in $FILES; do
    BASE_NAME=`basename "$FILE"`
    DIR_PATH=`dirname "$FILE"`;
    PASSWORD=`echo $BASE_NAME | sed -E $PATTERN`
    mkdir -p $DIR_PATH
    INPUT_PATH="$INPUT_DIR/$FILE"
    OUTPUT_PATH="$FILE"
    echo "$INPUT_PATH->$OUTPUT_PATH ($PASSWORD)"
    pdftk $INPUT_PATH input_pw $PASSWORD output "$OUTPUT_PATH"
done