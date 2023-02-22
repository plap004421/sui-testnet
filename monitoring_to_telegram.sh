#MONITORING LOCAL NODE, AND SEND INFO TO TELEGRAM BOT

#!/bin/bash

BOT_TOKEN=<>
CHAT_ID_INFO=<>
CHAT_ID_ALARM=<>

vers=$(/usr/local/bin/sui-node -V)

them=$(curl -s --location --request POST 'https://fullnode.testnet.sui.io:443/' --header 'Content-Type: application/json' \
  --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | jq .result)

us=$(curl -q localhost:9184/metrics 2>/dev/null | grep '^rocksdb_estimated_num_keys{cf_name="executed_transactions_to_checkpoint"}' | awk '{print $2}')

razn=$(($us-$them))

ip=$(curl checkip.amazonaws.com)

SUISTART=$(curl --location --request POST https://fullnode.testnet.sui.io:443 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' 2>/dev/null | jq .result)

NODESTART=$(curl --location --request POST 127.0.0.1:9000 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' 2>/dev/null | jq .result)

sleep 10

SUIEND=$(curl --location --request POST https://fullnode.testnet.sui.io:443 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' 2>/dev/null | jq .result)

NODEEND=$(curl --location --request POST 127.0.0.1:9000 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' 2>/dev/null | jq .result)

SUITPS=$((($SUIEND-$SUISTART)/10))
MYTPS=$((($NODEEND-$NODESTART)/10))


curl --header 'Content-Type: application/json' --request 'POST' --data '{"chat_id":"'"$CHAT_ID_INFO"'","text":"'"$name"', ip: '"$ip\n"' us: '"$us"', them: '"$them\n"' razn= '"$razn\n"' tps sui: '"$SUITPS"', tps node: '"$MYTPS\n"' '"$vers"'"}' "https://api.telegram.org/bot$BOT_TOKEN/sendMessage"

if (( "$razn" < "-10000" )) 
then
    curl --header 'Content-Type: application/json' --request 'POST' --data '{"chat_id":"'"$CHAT_ID_ALARM"'","text":"'"$name"', ip: '"$ip\n"' us: '"$us"', them: '"$them\n"' razn= '"$razn\n"' tps sui: '"$SUITPS"', tps node: '"$MYTPS\n"' '"$vers"'"}' "https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
fi
