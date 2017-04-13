#!/bin/bash

fail=0
for ex in *.in ; do
    base=${ex::-3}
    echo "running ${base}"
    ../SIMPSON $ex > ${base}.out
    # if .spe output check if it matches the gold standard data
    spe="${base},1.spe"
    if [ -f $spe -a -f gold/$spe ]; then
        if ! diff -q "$spe" "gold/$spe" &>/dev/null ; then
            echo "${base} $spe differs from gold/$spe"
            diff "$spe" "gold/$spe" > ${spe}.diff
            fail=1
        else
            echo "${base} $spe matches gold/$spe"
        fi
    else
        echo "gold/$spe not found for comparison"
    fi
    # if .fid output check if it matches the gold standard data
    fid="${base},1.fid"
    if [ -f $fid -a -f gold/$fid ]; then
        if ! diff -q "$fid" "gold/$fid" &>/dev/null ; then
            echo "${base} $fid differs from gold/$fid"
            diff "$fid" "gold/$fid" > ${fid}.diff
            fail=1
        else
            echo "${base} $fid matches gold/$fid"
        fi
    else
        echo "gold/$fid not found for comparison"
    fi
done
exit $fail
