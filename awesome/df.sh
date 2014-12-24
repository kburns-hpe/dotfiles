#!/bin/bash

# Disk Space function
diskusage() {
    drivepath=$1
    drivename=$2
    rawspace=$(btrfs fi df -b $drivepath | sed -e 's/.*total=\([0-9]*\),.*/\1/' | tr "\n" " " | sed -e 's/\ $/\n/' -e 's/\ /\ +\ /g' | bc)
    usedspace=$(echo $rawspace | awk '{printf "%.2f\n", $1/1024/1024/1024}')
    totalspace=$(df $drivepath | tail -n1 | awk '{printf "%.2f\n", $2/1024/1024}')
    freespace=$(echo $totalspace - $usedspace | bc -l)
    percentspace=$(echo $freespace/$totalspace\*100 | bc -l)
    printf "$drivename: %.0fGiB (%.1f%%)\n" $freespace $percentspace
}

diskusage "/home" "Home"
diskusage "/" "Root"
