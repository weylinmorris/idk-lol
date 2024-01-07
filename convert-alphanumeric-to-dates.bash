#!/bin/bash

# Function to get character definition as a 7x5 grid
get_character() {
    case $1 in
        0) echo "01110 10001 10001 10001 10001 10001 01110";;
        1) echo "00100 01100 00100 00100 00100 00100 01110";;
        2) echo "01110 10001 00001 00110 01000 10000 11111";;
        3) echo "01110 10001 00001 00110 00001 10001 01110";;
        4) echo "00010 00110 01010 10010 11111 00010 00010";;
        5) echo "11111 10000 10000 11110 00001 10001 01110";;
        6) echo "01110 10000 10000 11110 10001 10001 01110";;
        7) echo "11111 00001 00010 00100 01000 10000 10000";;
        8) echo "01110 10001 10001 01110 10001 10001 01110";;
        9) echo "01110 10001 10001 01111 00001 10001 01110";;
        A) echo "01110 10001 10001 11111 10001 10001 10001";;
        B) echo "11110 10001 10001 11110 10001 10001 11110";;
        C) echo "01110 10001 10000 10000 10000 10001 01110";;
        D) echo "11110 10001 10001 10001 10001 10001 11110";;
        E) echo "11111 10000 10000 11110 10000 10000 11111";;
        F) echo "11111 10000 10000 11110 10000 10000 10000";;
        G) echo "01110 10001 10000 10111 10001 10001 01111";;
        H) echo "10001 10001 10001 11111 10001 10001 10001";;
        I) echo "11111 00100 00100 00100 00100 00100 11111";;
        J) echo "11111 00010 00010 00010 10010 10010 01100";;
        K) echo "10001 10010 10100 11000 10100 10010 10001";;
        L) echo "10000 10000 10000 10000 10000 10000 11111";;
        M) echo "10001 11011 10101 10001 10001 10001 10001";;
        N) echo "10001 11001 10101 10011 10001 10001 10001";;
        O) echo "01110 10001 10001 10001 10001 10001 01110";;
        P) echo "11110 10001 10001 11110 10000 10000 10000";;
        Q) echo "01110 10001 10001 10001 10101 10010 01101";;
        R) echo "11110 10001 10001 11110 10100 10010 10001";;
        S) echo "01111 10000 10000 01110 00001 00001 11110";;
        T) echo "11111 00100 00100 00100 00100 00100 00100";;
        U) echo "10001 10001 10001 10001 10001 10001 01110";;
        V) echo "10001 10001 10001 10001 10001 01010 00100";;
        W) echo "10001 10001 10001 10101 10101 10101 01010";;
        X) echo "10001 01010 00100 00100 00100 01010 10001";;
        Y) echo "10001 01010 00100 00100 00100 00100 00100";;
        Z) echo "11111 00001 00010 00100 01000 10000 11111";;
        *) echo "00000 00000 00000 00000 00000 00000 00000";;  # Empty for unknown characters
    esac
}

# Function to get the first Sunday of the year
get_first_sunday() {
    local year=$1
    local date=$(date -j -f "%Y-%m-%d" "$year-01-01" "+%Y-%m-%d")
    while [ "$(date -j -f "%Y-%m-%d" "$date" "+%u")" != "7" ]; do
        date=$(date -j -v+1d -f "%Y-%m-%d" "$date" "+%Y-%m-%d")
    done
    echo "$date"
}

# Function to convert input string to GitHub graph dates
convert_to_dates() {
    local input=$1
    local year=$2
    local start_date=$(get_first_sunday "$year")
    local dates=()
    local week=0
    local day=0

    for ((i=0; i<${#input}; i++)); do
        char=$(echo "${input:$i:1}" | tr '[:lower:]' '[:upper:]')
        char_grid=$(get_character "$char")

        for row in {0..6}; do
            for col in {0..4}; do
                pixel=${char_grid:$((row*6+col)):1}
                if [ "$pixel" = "1" ]; then
                    date_to_add=$(date -j -v+"$((week+col))w" -v+"${row}d" -f "%Y-%m-%d" "$start_date" "+%Y-%m-%d")
                    dates+=("$date_to_add")
                fi
            done
        done

        week=$((week + 6))  # Move to the next character (5 columns + 1 space)
    done

    # Sort and remove duplicates
    printf '%s\n' "${dates[@]}" | sort -u
}

# Main script
echo "Enter an alphanumeric string (0-9, A-Z):"
read input_string
echo "Enter the year for the GitHub graph:"
read year

convert_to_dates "$input_string" "$year"
