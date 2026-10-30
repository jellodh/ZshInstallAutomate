# Jellodh Shell Automate

Universal auto-installers for Zsh and Bash - works on Termux, Ubuntu, Debian, Arch, Void (proot), Fedora, and more. Fixed for root / proot environments.

Created by Dh | jellodh
GitHub: github.com/jellodh

---

## Known Issue: Zsh Double Echo in Proot?

Yes, it is a known proot + zsh bug. Proot does not fully emulate a pty, so zsh's line editor (zle) double-reads input. You get double chars / spaces / randoms. Happens on Parrot, Void, Kali proot.

Solution: Use the Bash version in proot. It is 100 percent stable with the same features.

---

## Install

### 1) Zsh Version (Best for Termux main, Ubuntu, etc)

Features: oh-my-zsh + zsh-autosuggestions + zsh-syntax-highlighting

Using curl:

curl -fsSL https://raw.githubusercontent.com/jellodh/ZshInstallAutomate/main/jellodh-zsh.sh | bash
exec zsh

Using git:

git clone https://github.com/jellodh/ZshInstallAutomate.git
cd ZshInstallAutomate
chmod +x jellodh-zsh.sh
./jellodh-zsh.sh
exec zsh

### 2) Bash Version (Best for Void / Parrot / Kali proot)

Features: ble.sh (autosuggestions + syntax highlight) + starship + fzf + zoxide - No double echo, ever.

Using curl:

curl -fsSL https://raw.githubusercontent.com/jellodh/ZshInstallAutomate/main/jellodh-bash.sh | bash
exec bash

Using git:

git clone https://github.com/jellodh/ZshInstallAutomate.git
cd ZshInstallAutomate
chmod +x jellodh-bash.sh
./jellodh-bash.sh
exec bash

---

## What you get

| Feature | Zsh Installer | Bash Installer |
| :--- | :--- | :--- |
| Autosuggestions | Yes | Yes (ble.sh) |
| Syntax Highlighting | Yes | Yes |
| Pretty Prompt | random theme | starship |
| Stable in proot | No (known bug) | Yes |
| fzf + zoxide | No | Yes |

### Bash Shortcuts:
- Right Arrow - accept autosuggestion
- Ctrl + R - fzf history search
- z <dir> - smart jump (zoxide)

---

## Manual Fix for Double Echo (if you must use zsh in proot)

Add this to ~/.zshrc:

unset ZSH_AUTOSUGGEST_USE_ASYNC
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
stty sane

Make sure zsh-syntax-highlighting is LAST in plugins list.

---

## Thank you

Thank you for installing! | Dh
