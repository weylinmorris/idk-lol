#!/bin/bash

# Function to get character definition
get_character() {
    case $1 in
        0) echo " #### |#    #|#    #|#    #|#    #|#    #| #### ";;
        1) echo "  #   | ##   |  #   |  #   |  #   |  #   | ### ";;
        2) echo " #### |#    #|     #|  ### | #    |#     |######";;
        3) echo " #### |#    #|     #|  ### |     #|#    #| #### ";;
        4) echo "#   # |#   # |#   # |#   # |######|    # |    # ";;
        5) echo "######|#     |#     |##### |     #|#    #| #### ";;
        6) echo " #### |#     |#     |##### |#    #|#    #| #### ";;
        7) echo "######|     #|    # |   #  |  #   | #    |#     ";;
        8) echo " #### |#    #|#    #| #### |#    #|#    #| #### ";;
        9) echo " #### |#    #|#    #| #####|     #|#    #| #### ";;
        A) echo " #### |#    #|#    #|######|#    #|#    #|#    #";;
        B) echo "##### |#    #|#    #|##### |#    #|#    #|##### ";;
        C) echo " #### |#    #|#     |#     |#     |#    #| #### ";;
        D) echo "##### |#    #|#    #|#    #|#    #|#    #|##### ";;
        E) echo "######|#     |#     |##### |#     |#     |######";;
        F) echo "######|#     |#     |##### |#     |#     |#     ";;
        G) echo " #### |#    #|#     |#  ###|#    #|#    #| #### ";;
        H) echo "#    #|#    #|#    #|######|#    #|#    #|#    #";;
        I) echo "##### |  #   |  #   |  #   |  #   |  #   |##### ";;
        J) echo "######|    # |    # |    # |#   # |#   # | ###  ";;
        K) echo "#    #|#   # |#  #  |###   |#  #  |#   # |#    #";;
        L) echo "#     |#     |#     |#     |#     |#     |######";;
        M) echo "#    #|##  ##|# ## #|#    #|#    #|#    #|#    #";;
        N) echo "#    #|##   #|# #  #|#  # #|#   ##|#    #|#    #";;
        O) echo " #### |#    #|#    #|#    #|#    #|#    #| #### ";;
        P) echo "##### |#    #|#    #|##### |#     |#     |#     ";;
        Q) echo " #### |#    #|#    #|#    #|#  # #|#   # | ### #";;
        R) echo "##### |#    #|#    #|##### |#  #  |#   # |#    #";;
        S) echo " #### |#    #|#     | #### |     #|#    #| #### ";;
        T) echo "######|  #   |  #   |  #   |  #   |  #   |  #   ";;
        U) echo "#    #|#    #|#    #|#    #|#    #|#    #| #### ";;
        V) echo "#    #|#    #|#    #|#    #| #  # |  ##  |   #  ";;
        W) echo "#    #|#    #|#    #|# ## #|##  ##|#    #|#    #";;
        X) echo "#    #| #  # |  ##  |   #  |  ##  | #  # |#    #";;
        Y) echo "#    #| #  # |  ##  |   #  |   #  |   #  |   #  ";;
        Z) echo "######|     #|    # |   #  |  #   | #    |######";;
        *) echo "       |       |       |       |       |       |       ";;  # Empty for unknown characters
    esac
}

# Function to convert input string to 7-line high display format
convert_to_display() {
    local input=$1
    local output=""
    local line_count=7

    for ((i=0; i<line_count; i++)); do
        for ((j=0; j<${#input}; j++)); do
            char=$(echo "${input:$j:1}" | tr '[:lower:]' '[:upper:]')
            line=$(get_character "$char" | cut -d'|' -f$((i+1)))
            output+="$line  "
        done
        output+="\n"
    done

    echo -e "$output"
}

# Main script
echo "Enter an alphanumeric string (0-9, A-Z):"
read input_string

convert_to_display "$input_string"
