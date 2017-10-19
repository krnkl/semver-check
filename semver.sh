#!/usr/bin/env sh

function semverParseInto() {
    local RE='[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)'
    #MAJOR
    eval $2=`echo $1 | sed -e "s#$RE#\1#"`
    #MINOR
    eval $3=`echo $1 | sed -e "s#$RE#\2#"`
    #MINOR
    eval $4=`echo $1 | sed -e "s#$RE#\3#"`
    #SPECIAL
    eval $5=`echo $1 | sed -e "s#$RE#\4#"`
}
function semverGE() {
    local MAJOR_A=0 MINOR_A=0 PATCH_A=0 SPECIAL_A=0
    local MAJOR_B=0 MINOR_B=0 PATCH_B=0 SPECIAL_B=0
    semverParseInto $1 MAJOR_A MINOR_A PATCH_A SPECIAL_A
    # echo "$1 -> M: $MAJOR_A m:$MINOR_A p:$PATCH_A s:$SPECIAL_A"
    semverParseInto $2 MAJOR_B MINOR_B PATCH_B SPECIAL_B
    # echo "$2 -> M: $MAJOR_B m:$MINOR_B p:$PATCH_B s:$SPECIAL_B"
    [ $MAJOR_A -lt $MAJOR_B ] && return
    [[ $MAJOR_A -eq $MAJOR_B  && $MINOR_A -lt $MINOR_B ]] && return
    [[ $MAJOR_A -eq $MAJOR_B  && $MINOR_A -eq $MINOR_B && $PATCH_A -lt $PATCH_B ]] && return
    [[ $MAJOR_A -eq $MAJOR_B  && $MINOR_A -eq $MINOR_B && $PATCH_A -lt $PATCH_B && "_$SPECIAL_A"  == "_"  &&  "_$SPECIAL_B"  == "_" ]] && return
    [[ "_$SPECIAL_A" < "_$SPECIAL_B" ]] && return
    return 1
}

# returns non zero if first value is greater or equal than a second
semverGE $1 $2
res=$?
[ $res -eq 1 ] && { echo "ERROR: VERSION CANNOT BE SMALLER OR EQUAL TO THE CURRENT"; exit 1; }
