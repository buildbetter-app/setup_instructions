#!/bin/zsh
# install brew:
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.zprofile

echo "Installing basic apps"
brew install \
  --cask 1password \
  --cask 1password/tap/1password-cli \
  --cask Firefox \
  --cask iterm2 \
  --cask docker \
  --cask visual-studio-code \
  --cask linear-linear \
  --cask notion \
  --cask slack \
  --cask zoom \
  --cask around \
  --cask loom \
  --cask figma \
  pyenv \
  kubectl \
  gh \
  wget \
  mkcert \
  nss \
  nvm

softwareupdate --install-rosetta

echo "Logging into GitHub. Use HTTPS as preferred Git operations protocol:"
gh auth login
echo "Pulling backend and frontend repos"
gh repo clone buildbetter-app/frontend 
gh repo clone buildbetter-app/backend

echo "Setting sane git defaults"
git config --global init.defaultBranch main

echo "Configuring Python..."
echo "Installing global python 3.8.12 with pyenv"
pyenv install 3.8.12
pyenv global 3.8.12
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zprofile
eval "$(pyenv init -)"
echo "Updating pip..."
pip install --update pip

echo "Installing node"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" --no-use 
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zprofile
echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" --no-use' >> ~/.zprofile

echo "Installing aws cli. Run AWS configure manually"
pip install awscli

echo "Opening Firefox to instantiate a security database"
open -na /Applications/Firefox.app
echo "Installing mkcert..."
mkcert -install
echo "Quitting Firefox"
killall firefox

