#!/bin/bash

SUIFOLDER = $1
check = $2

cd ${SUIFOLDER}
git fetch upstream
git checkout -B testnet --track upstream/testnet

cargo build --release -p sui-node -p sui
sui-node --version

mv ${SUIFOLDER}/sui/target/release/sui-node /usr/local/bin/
mv ${SUIFOLDER}/sui/target/release/sui /usr/local/bin/

sui-node --version

#systemctl stop solana && systemctl restart suid.service && systemctl restart solana.service &&  journalctl -u suid -f
