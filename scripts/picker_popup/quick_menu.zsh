#!/bin/sh
LOCATION=/home/phil/work/pd/scripts/picker_popup/patterns

cat $LOCATION/* |
    rofi -dmenu -i -p | # open an interactive menu; passes the selection to the pipe
    sed "s/  .*//" |    # remove the keywords after the selection
    sed "s/$ //" |      # remove leading space
    tr -d '\n' |        # remove final \n
    xclip -selection c  # copy to clipboard
