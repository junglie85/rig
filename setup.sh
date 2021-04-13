#!/usr/bin/env bash

# Given the name of a Homebrew formula, check if it is istalled and if not, install it.
fetch_brew_dependency() {
    FORMULA_NAME=$1

    echo "Fetching Brew dependency: '${FORMULA_NAME}'."

    if brew ls --versions ${FORMULA_NAME} > /dev/null; then
        echo "Dependency '${FORMULA_NAME}' is already installed, continuing ..."
    else
        echo "Dependency '${FORMULA_NAME}' is not installed, installing via Homebrew ..."
        brew install ${FORMULA_NAME}
    fi
}

# Create new SSH key if ir_rsa does not exist

# Install Xcode command line tools
xcode-select --install

# Configure Git
git config --global credential.helper osxkeychain

git config --global alias.br "branch"
git config --global alias.co "checkout"
git config --global alias.st "status"
git config --global alias.staged "diff --staged"
git config --global alias.prune-branches "fetch origin --prune"
git config --global alias.l "log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short"
git config --global alias.ld "log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short --since=1.days"
git config --global alias.lw "log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short --since=1.weeks"

# Install Homebrew

# Install latest bash shell

# Install bash-it

# Configure bash-it theme

# Download font from JetBrains

# Install font

# Configure terminal size, theme and font

# Add bash to list of shells

# Set bash as default shell

# Set bash completion
# TODO: check to see if already set. grep?
cat << EOF >> ~/.bash_profile
# Load bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

EOF

# Install tools
fetch_brew_dependency jenv
fetch_brew_dependency poetry
fetch_brew_dependency tree
fetch_brew_dependency ack
fetch_brew_dependency rustup

fetch_brew_dependency coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Install VScode

# Add VScode to PATH - need to check if already in PATH before adding.
#echo "Add VSCode to PATH ..."
#cat << EOF >> ~/.bash_profile
## Add Visual Studio Code (code)
#export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
#EOF
#source ~/.bash_profile

# Configure VSCode
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cmake-tools
code --install-extension twxs.cmake
code --install-extension tinkertrain.theme-panda

# Set aliases
set_alias() {
# TODO: add check to see if alias aready exists. grep?
    ALIAS=$1
    COMMAND=$2

    echo "alias ${ALIAS}=\"${COMMAND}\"" >> ~/.bash_profile
}

echo "# Aliases" >> ~/.bash_profile
set_alias aliases "cat ~/.bash_profile | grep alias"
set_alias reload "source ~/.bash_profile"
set_alias ls "ls --color"
set_alias lsa "ls -la --color"
set_alias a "source venv/bin/activate"
set_alias d "deactivate"
set_alias mkenv "pyenv local  && python -m venv venv"
set_alias gb "git br"
set_alias gc "git commit"
set_alias gco "git co"
set_alias gl "git l"
set_alias gp "git push"
set_alias gpf "git push --force-with-lease"
set_alias gs "git st"

