setopt auto_cd
setopt auto_pushd
setopt chase_links
setopt pushd_ignore_dups
setopt pushd_to_home

cdpath=($HOME)
chpwd_functions=($chpwd_functions dirs)

setopt bad_pattern
setopt bare_glob_qual
setopt case_glob
setopt case_match
setopt csh_null_glob # null_glob
setopt equals
setopt extended_glob
setopt glob
setopt magic_equal_subst
setopt mark_dirs
setopt multibyte
setopt nomatch
setopt numeric_glob_sort
setopt rc_expand_param
setopt rematch_pcre
setopt unset

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE

setopt append_history
setopt extended_history
setopt no_hist_beep
setopt hist_expand # bang_hist
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_by_copy
setopt hist_verify
setopt inc_append_history
setopt share_history

autoload history-search-end

setopt global_export
setopt global_rcs
setopt rcs

setopt aliases
setopt clobber
setopt no_flow_control
setopt ignore_eof
setopt hash_cmds
setopt hash_dirs
setopt path_dirs
setopt short_loops

setopt bg_nice
setopt check_jobs
setopt hup
setopt long_list_jobs
setopt notify

setopt exec
setopt multios

setopt no_beep
