#!/bin/bash

# Script d'installation pour le minage de BITZ
# À lancer avec : bash bitz-setup.sh

set -e

echo "=== 1. Mise à jour et installation des paquets requis ==="
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install screen curl nano -y

echo "=== 2. Installation de Rust ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo "=== 3. Installation de la CLI Solana ==="
curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash

# S'assurer que Solana CLI est dans le PATH
if ! command -v solana &> /dev/null; then
  echo 'export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi

echo "=== Vérification de la version de Solana ==="
solana --version

echo "=== 4. Configuration du RPC ==="
solana config set --url https://eclipse.helius-rpc.com/

echo "=== 5. Configuration du wallet Solana ==="
mkdir -p ~/.config/solana/
cat > ~/.config/solana/id.json <<EOF
[3,52,253,207,129,49,229,143,99,49,97,226,77,180,28,100,188,208,186,82,64,96,82,252,173,20,202,69,47,141,198,42,58,112,119,203,45,247,165,124,185,191,148,43,35,42,146,182,212,67,91,215,99,88,101,162,227,53,251,228,47,92,184,51]
EOF

echo "=== 6. Installation de BITZ ==="
cargo install bitz

echo "=== 7. Démarrage du minage ==="
echo "Commande pour miner :"
bitz collect -p https://mainnet-pool.powpow.app"
