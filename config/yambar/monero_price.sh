#!/usr/bin/env sh

while true; do
    current_price="$(curl -s -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=monero&vs_currencies=usd' -H  'accept: application/json' | jq .monero.usd)"
    echo "price|float|${current_price}"
    echo ""
    sleep 60
done
