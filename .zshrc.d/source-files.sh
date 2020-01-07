sourced_files=(
    /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
)
for file in "${sourced_files[@]}" ; do
  if [ -f "${file}" ]; then
    source "${file}"
  fi
done
