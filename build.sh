#!/bin/bash

set -e

main() {
 for reviewDate in $(readmeDates)
 do
   twoWeeksInSeconds=$(expr 60 \* 60 \* 24 \* 14)
   nextReviewDate=$(date -j -f "%d/%m/%y" "$(echo $reviewDate)" +"%s")
   todayDate=$(date -j -f "%Y%m%d" "$(date +%Y%m%d)" "+%s")
   reviewDateBarrier=$(expr $todayDate - $twoWeeksInSeconds)

   if [ $reviewDateBarrier -gt $nextReviewDate ];
   then
     echo "$reviewDate ALERT ALERT"
     grep -F $reviewDate README.md
     exit 1
   else
     echo "$reviewDate not due"
   fi
 done
}

readmeDates() {
 awk '/\| ([0-9]{2}\/[0-9]{2}\/[0-9]{2})   \| / { print $4 }' README.md | grep -v 'DD'
}

main
