#!/bin/bash

  cd /root/solana/sui/
  git fetch upstream
  git checkout -B testnet --track upstream/testnet

  cargo build --release -p sui-node -p sui
  sui-node --version
  
  mv target/release/sui-node /usr/local/bin/
  mv target/release/sui /usr/local/bin/

  sui-node --version

#systemctl stop solana && systemctl restart suid.service && systemctl restart solana.service
