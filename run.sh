#! /bin/sh

VERSION="0.1"

USAGE="Usage: $0 [options] stockid1,stockid2 ...
Options:
    -s Show the latest stock price of following stocks 
    -V VERSION Tool's Version
    -h This ;-)
"
while getopts "s:Vh" OPTION
do
    case $OPTION in
        s) ST="$OPTARG"; shift 2 ;;
        V) echo "$VERSION"; shift 1; exit;;
        h) echo "$USAGE"; shift 1; exit;;
    esac
done

#ST=$1;
OLD_IFS="$IFS"
IFS=",";
arr=$ST;
IFS="$OLD_IFS"

while true;
do
   curl -Ls -o temp http://hq.sinajs.cn/list=$ST;
   clear;
   IFS=",";
   for s in ${arr}
      do
         line=$(cat temp |grep $s);
         YC=$(echo $line | awk  {'print $4'});
         CP=$(echo $line | awk  {'print $5'});
         TR=$(echo "scale=2;100*($CP-$YC)/$YC"|bc);
         echo $CP "  "$TR;
      done
   IFS="$OLD_IFS"；
done
