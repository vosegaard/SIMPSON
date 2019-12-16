#!/bin/bash

set -e
numdiff="$1 -a 1e-10"
fail=0

# colors & names of the log levels
# check if stdout is a terminal...
if test -t 1; then
    # see if it supports colors...
    ncolors=$(tput colors)
    if test -n "$ncolors" && test "$ncolors" -ge 8; then
        normal="$(tput sgr0)"
        bold="$(tput bold)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
        yellow="$(tput setaf 3)"
        cyan="$(tput setaf 6)"
        white="$(tput setaf 7)"
        magenta="$(tput setaf 5)"
    fi
fi

for ex in *.in ; do
    base=${ex::-3}
    echo "---- running ${base} ----"
    rm -f "${base}.out" "${base}*.spe" "${base}*.fid"
    if ! ../SIMPSON $ex > "${base}.out" ; then
        echo "${magenta}SIMPSON $ex failed!${normal}"
        fail=1
        continue
    fi
    # if .spe output check if it matches the gold standard data
    # if .fid output check if it matches the gold standard data
    files=$(shopt -s nullglob; echo ${base}*.spe ${base}*.fid)
    for spe in $files ; do
        if [ -f "$spe" -a -f "gold/$spe" ]; then
            if ! $numdiff "$spe" "gold/$spe" &>/dev/null ; then
                echo "${magenta}${base} $spe differs from gold/$spe"
                echo " $numdiff $spe gold/$spe${normal}"
                : $numdiff "$spe" "gold/$spe" > "${spe}.diff"
                fail=1
            else
                echo "${base} $spe matches gold/$spe"
            fi
        else
            echo "${red}gold/$spe not found for comparison${normal}"
        fi
    done
done
echo "done testall.sh"
exit $fail
