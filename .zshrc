# ---[ ZSH Options ]----------------------------------------------------
# # General
setopt   NO_BEEP CLOBBER
setopt   MULTIOS CORRECT_ALL AUTO_CD
setopt   CD_ABLE_VARS
#
# # does not work together nicely with menu select:
# #setopt   BASH_AUTO_LIST
# #setopt   NO_LIST_AMBIGUOUS
#
# # History
setopt   INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt	 HIST_EXPIRE_DUPS_FIRST
# #setopt  SHARE_HISTORY
setopt   HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zhistory
DIRSTACKSIZE=20
#
#
# # ---[ Modules ]-------------------------------------------------------
zmodload -i zsh/complist
autoload -Uz compinit
compinit
#
#
# # ---[ Completition system ]-------------------------------------------
#
# # If unset, the cursor is set to the end of the word if completion is
# # started. Otherwise it stays there and completion is done from both ends.
# # This is needed for the prefix completer
setopt COMPLETE_IN_WORD
# # don't move the cursor to the end AFTER a completion was inserted
setopt NO_ALWAYS_TO_END
#
setopt LIST_PACKED
#
# # Prevents aliases on the command line from being internally substituted before completion is attempted.
# # The effect is to make the alias a distinct command for completion purposes.
# #setopt COMPLETE_ALIASES
#
# # turn off old compctl completion
# #zstyle ':completion:*' use-compctl false
#
# # which completers to use
# #
# # for use with expand-or-complete-prefix :
# #zstyle ':completion:*' completer _complete _match _list _ignored _correct _approximate
# # for use with expand-or-complete :
zstyle ':completion:*' completer _complete _match _prefix:-complete _list _correct _approximate _prefix:-approximate _ignored
# # _list anywhere to the completers always only lists completions on first tab
#
zstyle ':completion:*:prefix-complete:*' completer _complete
zstyle ':completion:*:prefix-approximate:*' completer _approximate
#
# # configure the match completer, more flexible of GLOB_COMPLETE
# # with original set to only it doesn't act like a `*' was inserted at the cursor position
zstyle ':completion:*:match:*' original only
#
# # first case insensitive completion, then case-sensitive partial-word completion, then case-insensitive partial-word completion
# # (with -_. as possible anchors)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
#
# # allow 2 erros in correct completer
zstyle ':completion:*:correct:*' max-errors 2 not-numeric
# ## allow one error for every three characters typed in approximate completer
# zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
#
# # meu selection with 2 candidates or more
zstyle ':completion:*' menu select=2
# #zstyle ':completion:*' menu select=1 _complete _ignored _approximate
#
# # Add colors in completions
# eval $(dircolors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload colors && colors
#
# # Messages/warnings format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[01;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:messages' format $'%{\e[01;04;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:warnings' format $'%{\e[01;04;31m%}---- No matches for: %d%{\e[m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[m%}'
 # make completions appear below the description of which listing they come from
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s

# ## Some functions, like _apt and _dpkg, are very slow. You can use a cache in order to proxy the list of results:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#
# # complete man pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
#
# # ignore uninteresting user accounts
zstyle ':completion:*:*:*:users' ignored-patterns \
#     adm apache avahi avahi-autoipd backup bind bin cl-builder colord couchdb daemon dictd festival \
#         games gdm gnats haldaemon halt hplip ident identd irc jetty junkbust kernoops libuuid lightdm \
#             list lp mail mailnull man messagebus named news nfsnobody nobody nscd ntp operator pcap postfix \
#                 postgres proxy pulse radvd rpc rpcuser rpm rtkit saned shutdown speech-dispatcher squid sshd \
#                     statd stunnel4 sync sys syslog uucp usbmux vcsa vde2-net www-data xfs
#
#                     # ignore uninteresting hosts
#                     zstyle ':completion:*:*:*:hosts' ignored-patterns \
#                         localhost loopback ip6-localhost ip6-loopback localhost6 localhost6.localdomain6 localhost.localdomain
    #
    #                         #hosts=( $(</etc/hosts) )
    #                         # 1. All /etc/hosts hostnames are in autocomplete
    #                         # 2. If you have a comment in /etc/hosts like #%foobar.domain,
    #                         #    then foobar.domain will show up in autocomplete!
    #                         #myhosts=( $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') )
    #                         #zstyle ':completion:*:(ping|mtr|ssh|scp|sftp):*' hosts $myhosts
    #                         #zstyle ':completion:*:(ssh|scp|sftp):*' users $users
    #
    #
#tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
    #
    #                         ## If you end up using a directory as argument, this will remove the trailing slash (usefull in ln):
    #                         #zstyle ':completion:*' squeeze-slashes true
    #
    #                         ## cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
    #
zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
    #
    #                         ## ignores filenames already in the line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
    #
    #                         ## Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'
    #
    #                         ## don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
    #
    #                         # A newly added command will may not be found or will cause false
    #                         # correction attempts, if you got auto-correction set. By setting the
    #                         # following style, we force accept-line() to rehash, if it cannot
    #                         # find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true
    #
if [[ $(uname) == "Darwin" ]]
then
    OSP=""
elif [[ $(uname) == "Hyperbola" ]]
then
    OSP=""
else
    OSP="󰣇"
fi

lam='%(?:%F{#cf73e6} :%F{#821a1a} ) %F{#d0d0d0} '

PROMPT=" %F{#d0d0d0}${OSP} %F{#91aadf}%~
 ${lam}"

RPROMPT="%*"
bindkey -v

export AOC_TOKEN="53616c7465645f5f25ed2a37c365ce042310bebe18e4f84883dca21f0b2a905ec3260bf77191b4cd18fa3d2ff1d0f99b035d4f3edeba2c29ba0f1053c801dfb5"

neofetch
