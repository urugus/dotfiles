# Bind keys

# only ~/.bashrc or ~/.bash_profile
if [[ $- == *i* ]]; then
  # search history
  bind -x '"\C-r":"fzf_history"'
  bind -x '"\C-o":"fzf_directory"'
fi
