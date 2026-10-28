#!/bin/bash
# jellodh-zsh.sh - Universal ZSH by jellodh - github.com/jellodh
if [ "$EUID" -eq 0 ] && [ -n "$SUDO_USER" ]; then exec sudo -u $SUDO_USER bash "$0"; fi
IS_TERMUX=0; [ -d "/data/data/com.termux" ] && IS_TERMUX=1
echo "Installing jellodh ZSH..."
if [ $IS_TERMUX -eq 1 ]; then pkg update -y >/dev/null 2>&1; pkg install -y zsh git curl fzf >/dev/null 2>&1
else command -v apt >/dev/null 2>&1 && sudo apt update -y >/dev/null 2>&1 && sudo apt install -y zsh git curl fzf >/dev/null 2>&1
command -v xbps-install >/dev/null 2>&1 && sudo xbps-install -Sy zsh git curl fzf >/dev/null 2>&1
command -v pacman >/dev/null 2>&1 && sudo pacman -Sy --noconfirm zsh git curl fzf >/dev/null 2>&1
fi
export RUNZSH=no; export CHSH=no
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >/dev/null 2>&1
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}; mkdir -p "$ZSH_CUSTOM/plugins"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" >/dev/null 2>&1
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" >/dev/null 2>&1
[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && git clone --depth=1 https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions" >/dev/null 2>&1
cat > "$HOME/.zshrc" <<'ZSHRC'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=(robbyrussell bira af-magic crunch fino fishy fox gallois kolo minimal mrtazz pygmalion sorin duellj agnoster)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions fzf extract sudo history)
source $ZSH/oh-my-zsh.sh
export GITHUB_USER="jellodh"
alias ll='ls -lah --color=auto'
alias c='clear'
HISTSIZE=10000; SAVEHIST=10000
echo "Theme: $ZSH_THEME"
echo "------------------------------------------------"
echo " Thank you! | github.com/jellodh"
echo "------------------------------------------------"
ZSHRC
ZSH_BIN=$(command -v zsh 2>/dev/null); [ -z "$ZSH_BIN" ] && ZSH_BIN="$PREFIX/bin/zsh"; [ -z "$ZSH_BIN" ] && ZSH_BIN="/usr/bin/zsh"
if [ $IS_TERMUX -eq 1 ]; then grep -q "exec zsh" "$HOME/.bashrc" 2>/dev/null || echo 'command -v zsh >/dev/null && exec zsh' >> "$HOME/.bashrc"
else chsh -s "$ZSH_BIN" >/dev/null 2>&1 || sudo chsh -s "$ZSH_BIN" "$USER" >/dev/null 2>&1 || true
grep -q "exec zsh" "$HOME/.bashrc" 2>/dev/null || echo 'command -v zsh >/dev/null && exec zsh' >> "$HOME/.bashrc"; fi
chown -R $(whoami) "$HOME/.zshrc" "$HOME/.oh-my-zsh" 2>/dev/null || true
echo "Done! github.com/jellodh - Thank you! Run: zsh"
