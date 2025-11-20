#!/usr/bin/env bash
set -e

echo "[1/4] Installing Helix..."
sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo apt update -y
sudo apt install -y helix

echo "[2/4] Installing Node.js + npm..."
if ! command -v npm >/dev/null 2>&1; then
    sudo apt install -y nodejs npm
fi

echo "[3/4] Installing Pyright..."
sudo npm install -g pyright

echo "[4/4] Writing Helix Python config..."
mkdir -p ~/.config/helix

cat > ~/.config/helix/languages.toml << 'EOF'
[[language]]
name = "python"
language-servers = ["pyright"]
formatter = { command = "black", args = ["-"] }

[language-server.pyright]
command = "pyright-langserver"
args = ["--stdio"]
EOF

echo ""
echo "✔ Helix Python autocomplete enabled"
echo ""
echo "Open a file:"
echo "    hx test.py"
echo "Press Ctrl + Space to trigger autocomplete"
echo ""
