# 1Password CLI
if command -v op >/dev/null; then
  eval "$(op completion zsh)"
  compdef _op op
fi