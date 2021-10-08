#!/bin/sh

echo "Installing packages..."
sudo apt install gcc g++ cmake git sqlite3 libsqlite3-dev
echo ""


exists() {
  type "$1" &> /dev/null;
}


if ! exists zoxide; then
  curl -sS https://webinstall.dev/zoxide | bash
fi
sleep 0.1

if ! exists lazygit; then
  sudo add-apt-repository ppa:lazygit-team/release
  sudo apt-get update
  sudo apt-get install lazygit
fi
sleep 0.1

if ! exists nvim; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install neovim
fi
sleep 0.1

if ! exists node; then
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi
sleep 0.1

if ! exists gh; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install gh
fi
sleep 0.1


echo "=============="
echo "   dotfiles   "
echo "=============="

export DOTFILES="$HOME/dotfiles"

if [ -d "$DOTFILES" ]; then
  echo "Dotfiles have already been cloned"
else
  git clone git@github.com:xiyaowong/dotfiles $DOTFILES
fi

cd "$DOTFILES" && $DOTFILES/install
