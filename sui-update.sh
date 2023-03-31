#!/bin/bash

function=main
C_LGn='\033[1;32m'
C_R='\033[0;31m'
RES='\033[0m'

printf_n(){ printf "$1\n" "${@:2}"; }

main(){
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
  }
  
$function  

#systemctl stop solana && systemctl restart suid.service && systemctl restart solana.service &&  journalctl -u suid -f
