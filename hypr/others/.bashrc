# .bashrc
  eval "$(starship init bash)"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"
alias vim='nvim'
alias sn='shutdown -h now'
alias nd='npm run dev'
alias cr='cargo run'
alias ni='npm install'
alias cl='clear'
alias b="cd ../"
alias bb="cd ../../"
alias bbb="cd ../../../"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
