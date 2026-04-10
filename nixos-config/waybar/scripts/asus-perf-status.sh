#!/bin/bash
mode=$(asusctl profile get | awk '/Active profile/ {print $NF}')
case "$mode" in
  Quiet)       echo "Quiet" ;;
  Balanced)    echo "Balanced" ;;
  Performance) echo "Performance" ;;
  *)           echo "broken" ;;
esac
