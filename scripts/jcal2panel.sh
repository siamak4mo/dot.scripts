#!/bin/sh
#
#  jcal to panel
#
#  output:
#   - MODE 0:  [۳۱ خرداد]
#   - MODE 1:  چهارشنبه ۳۱ خرداد  [21 Jun]
#
while test $# -gt 0; do
    case "$1" in
        -m | --mod | --mode)
            MODE=$2
            shift 2;;
        *)
            exit 1
    esac
done

[ -z "$MODE" ] && MODE=0
JDATE=$(which jdate)
DATE=$(which date)


case $MODE in
    0)
        _j=$($JDATE +%d" "%V -f)
        printf " [%s] " "$_j"
        ;;
    1)
        _j=$($JDATE +%G" "%d" "%V -f)
        _d=$($DATE +%-1e" "%b)
        printf "%s  [%s]  " "$_j" "$_d"
        ;;
    *)
        printf "Not Implemented.\n" >&2;;
esac
