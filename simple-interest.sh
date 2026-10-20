#!/bin/bash

echo "Simple Interest Calculator"

read -p "Enter principal amount: " principal
read -p "Enter annual interest rate (%): " rate
read -p "Enter time in years: " time

if ! [[ "$principal" =~ ^[0-9]+([.][0-9]+)?$ ]] ||
   ! [[ "$rate" =~ ^[0-9]+([.][0-9]+)?$ ]] ||
   ! [[ "$time" =~ ^[0-9]+([.][0-9]+)?$ ]] ||
   ! awk -v p="$principal" -v t="$time" \
      'BEGIN { exit !(p > 0 && t > 0) }'
then
    echo "Invalid input. Enter valid positive amounts and time, and a non-negative rate."
    exit 1
fi

interest=$(awk -v p="$principal" -v r="$rate" -v t="$time" \
    'BEGIN { printf "%.2f", (p * r * t) / 100 }')

total=$(awk -v p="$principal" -v i="$interest" \
    'BEGIN { printf "%.2f", p + i }')

echo "Simple Interest: $interest"
echo "Total Amount: $total"
