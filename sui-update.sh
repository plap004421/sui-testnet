#!/bin/bash

SUIFOLDER = $1

cd ${SUIFOLDER}
git checkout $2

cargo build --release -p sui-node -p sui
mv ${SUIFOLDER}/sui/target/release/sui-node /usr/local/bin/
mv ${SUIFOLDER}/sui/target/release/sui /usr/local/bin/

sui-node --version

#systemctl stop solana && systemctl restart suid.service && systemctl restart solana.service &&  journalctl -u suid -f
