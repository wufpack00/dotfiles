# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="robbyrussell"
plugins=( colored-man-pages extract git zsh-autosuggestions zsh-syntax-highlighting)

# skip the verification of insecure directories
ZSH_DISABLE_COMPFIX=true

# Load personal pre oh-my-zsh init config which should be stored in ~/.zshrc.personal.before
# E.g. setting ZSH theme etc
if [ -f ~/.zshrc.personal.before ]; then . ~/.zshrc.personal.before; fi

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load personal ZSH config which should be stored in ~/.zshrc.personal.after
# Most ZSH config e.g. aliases etc goes here
if [ -f ~/.zshrc.personal.after ]; then . ~/.zshrc.personal.after; fi

# enable Powerlevel10k theme installed via homebrew
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
