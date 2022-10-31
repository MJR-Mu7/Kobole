## KOBOLE TESTNET - MUCHATHA

Kobole NPoS,Nominated Proof of Stake, is an NFT enabled DAO enabling WASM Smart Contracts.
🚀 ❤️ 🚀 ❤️

Follow the steps below to get started with Kobole.

## Docker build Kobole.


    docker build -t kobole .

    docker run -it -u 0 --restart=always --net=host kobole:latest --chain live --base-path /kobole/validator1 --validator --name Cpt_Stee --ws-port 9946 --port 30336 --rpc-port 9936 --rpc-cors all --unsafe-rpc-external


## Run Kobole Container<ROOT>.


    docker run -it -u 0 --restart=always --net=host kobole:latest --chain live --base-path /validator1 --validator --name <Validator-Name> --ws-port 9945 --port 30336 --rpc-port 9936 --rpc-cors all --bootnodes /ip4/<Bootnode-IP-Addess>/tcp/30333/wss/p2p/<BootNodekey>


eg

## Bootnode.


      docker run -it --restart=always --net=host kobole:latest --node-key <generated-node-key> --base-path /tmp/bootnode1 --chain=live --name <node-name> --unsafe-ws-external --unsafe-rpc-external --prometheus-external --port 30333 --ws-port 9945 --rpc-cors all


## No Root.

      docker run -it --restart=always --net=host kobole:latest --chain live --base-path /tmp/validator1 --validator --name Cpt.Stee --ws-port 9945 --port 30336 --rpc-port 9936 --rpc-cors all --bootnodes /ip4/<Bootnode-IP-Addess>/tcp/30333/wss/p2p/<BootNodekey>


## Install Keys in keystore.

Inside kobole docker container do . Replace 0x0000..... with your secret key to enable signing and validating of the blocks



      kobole key insert --key-type babe --base-path /tmp/validator1 --scheme Sr25519 --chain live --suri 0x0000...... --password-interactive

      kobole key insert --key-type gran --base-path /tmp/validator1 --scheme Ed25519 --chain live --suri 0x0000...... --password-interactive



or using Docker do . Replace 0x0000..... with your secret key to enable signing and validating of the blocks.



      docker run -it --rm --net=host kobole:latest key insert --key-type babe --base-path /tmp/validator1 --scheme Sr25519 --chain live --suri 0x0000...... --password-interactive

      docker run -it --rm --net=host kobole:latest key insert --key-type gran --base-path /tmp/validator1 --scheme Ed25519 --chain live --suri 0x0000...... --password-interactive
