# This script changes the color of the $ character in the prompt depending on
# whether on the vi-mode the user is in.
#
# Also contains custom vi bindings that makes me happy.
#
# Original script came from zsh mailing list:
# http://www.zsh.org/mla/users/2006/msg00079.html

autoload -U colors && colors

# The cryptic %(!.#.$) means if I'm running as super user print # otherwise
# print $.
PROMPT="%{$fg[green]%}[%T] %n@%m - %~
%(!.#.$) %{$reset_color%}"
RPROMPT=""

redisplay() {
   builtin zle .redisplay
   ( true ; show_mode "INSERT") &!
}
redisplay2() {
   builtin zle .redisplay
   (true ; show_mode "NORMAL") &!
}
zle -N redisplay
zle -N redisplay2
bindkey -M viins "^X^R" redisplay
bindkey -M vicmd "^X^R" redisplay2

screenclear () {
   echo -n $'\e[2J\e[400H'
   builtin zle .redisplay
   (true ; show_mode "INSERT") &!
}
zle -N screenclear
bindkey "^L" screenclear

show_mode() {
   local x
   local pos=0
   x=$CURSOR
   # we do the vi thing in reverse, highlight something when
   # in cmd mode otherwise nothing
   case $1 in
        "NORMAL")
        builtin echotc LEFT $COLUMNS
        echo -n "$fg[cyan]$ $reset_color"
        CURSOR=$x
        builtin echotc LEFT $COLUMNS
        builtin echotc RIGHT $((x + 2)) # prompt
        ;;
        "INSERT")
        builtin echotc LEFT $COLUMNS
        echo -n "$fg_bold[green]$ $reset_color"
        CURSOR=$x
        builtin echotc LEFT $COLUMNS
        builtin echotc RIGHT $((x + 2)) # prompt
        ;;
   esac
}

###       vi-add-eol (unbound) (A) (unbound)
###              Move  to the end of the line and enter insert mode.

vi-add-eol() {
   show_mode "INSERT"
   builtin zle .vi-add-eol
}
zle -N vi-add-eol
bindkey -M vicmd "A" vi-add-eol

###       vi-add-next (unbound) (a) (unbound)
###              Enter insert mode after the  current  cursor  posi­
###              tion, without changing lines.

vi-add-next() {
   show_mode "INSERT"
   builtin zle .vi-add-next
   # OLDLBUFFER=$LBUFFER
   # OLDRBUFFER=$RBUFFER
   # NNUMERIC=$NUMERIC
   # bindkey -M viins $'\e' vi-cmd-mode-a
}
zle -N vi-add-next
bindkey -M vicmd "a" vi-add-next

#vi-cmd-mode-a() {
#   show_mode "NORMAL"
#   STRING="LLBUFFER=\${LBUFFER:s/$OLDLBUFFER//}"
#   eval $STRING
#   STRING="RRBUFFER=\${RBUFFER:s/$OLDRBUFFER/}"
#   eval $STRING
#   INS="$LLBUFFER$RRBUFFER"
#   LBUFFER=$OLDLBUFFER
#   repeat $NNUMERIC LBUFFER="$LBUFFER$INS"
#   builtin zle .vi-cmd-mode
#   unset LLBUFFER RRBUFFER NNUMERIC INS
#   bindkey -M viins $'\e' vi-cmd-mode
#}
#zle -N vi-cmd-mode-a

###       vi-change (unbound) (c) (unbound)
###              Read a movement command from the keyboard, and kill
###              from  the  cursor  position  to the endpoint of the
###              movement.  Then enter insert mode.  If the  command
###              is vi-change, change the current line.

vi-change() {
   show_mode "INSERT"
   builtin zle .vi-change
}
zle -N vi-change
bindkey -M vicmd "c" vi-change

###       vi-change-eol (unbound) (C) (unbound)
###              Kill  to the end of the line and enter insert mode.

vi-change-eol() {
   show_mode "INSERT"
   builtin zle .vi-change-eol
}
zle -N vi-change-eol
bindkey -M vicmd "C" vi-change-eol

###       vi-change-whole-line (unbound) (S) (unbound)
###              Kill the current line and enter insert mode.

vi-change-whole-line() {
   show_mode "INSERT"
   builtin zle .vi-change-whole-line
}
zle -N vi-change-whole-line
bindkey -M vicmd "S" vi-change-whole-line

###       vi-insert (unbound) (i) (unbound)
###              Enter insert mode.

vi-insert() {
   show_mode "INSERT"
   builtin zle .vi-insert
}
zle -N vi-insert
bindkey -M vicmd "i" vi-insert

###       vi-insert-bol (unbound) (I) (unbound)
###              Move to the first non-blank character on  the  line
###              and enter insert mode.

vi-insert-bol() {
   show_mode "INSERT"
   builtin zle .vi-insert-bol
}
zle -N vi-insert-bol
bindkey -M vicmd "I" vi-insert-bol

###       vi-open-line-above (unbound) (O) (unbound)
###              Open a line above the cursor and enter insert mode.

vi-open-line-above() {
   show_mode "INSERT"
   builtin zle .vi-open-line-above
}
zle -N vi-open-line-above
bindkey -M vicmd "O" vi-open-line-above

###       vi-open-line-below (unbound) (o) (unbound)
###              Open a line below the cursor and enter insert mode.

vi-open-line-below() {
   show_mode "INSERT"
   builtin zle .vi-open-line-below
}
zle -N vi-open-line-below
bindkey -M vicmd "o" vi-open-line-below

###       vi-substitute (unbound) (s) (unbound)
###              Substitute the next character(s).

vi-substitute() {
   show_mode "INSERT"
   builtin zle .vi-substitute
}
zle -N vi-substitute
bindkey -M vicmd "s" vi-substitute

###       vi-replace (unbound) (R) (unbound)
###              Enter overwrite mode.
###

vi-replace() {
   show_mode "REPLACE"
   builtin zle .vi-replace
}
zle -N vi-replace
bindkey -M vicmd "R" vi-replace

###       vi-cmd-mode (^X^V) (unbound) (^[)
###              Enter  command  mode;  that  is, select the `vicmd'
###              keymap.  Yes, this is bound  by  default  in  emacs
###              mode.

vi-cmd-mode() {
   show_mode "NORMAL"
   builtin zle .vi-cmd-mode
}
zle -N vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

###       vi-oper-swap-case
###              Read a movement command from the keyboard, and swap
###              the case of all characters from the cursor position
###              to the endpoint of the movement.  If  the  movement
###              command  is vi-oper-swap-case, swap the case of all
###              characters on the current line.
###
bindkey -M vicmd "g~" vi-oper-swap-case

# Bind some keys to noop. Doesn't work :(
noop() {}
zle -N noop
bindkey -M vicmd '\e' noop

bindkey -M vicmd "^R" redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "ga" what-cursor-position

# So that we can backspace after where we went into insert mode
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" kill-line

# Typing v in normal mode allows command line to be edited in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Get Ctrl-R emacs equivalent behavior.
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M viins "^R" history-incremental-search-backward

# Use emacs's CTRL-A and CTRL-E when in insert mode.
bindkey -M viins "^A" vi-insert-bol
bindkey -M viins "^E" vi-add-eol

# Enable vi mode. By default, it's emacs mode.
bindkey -v
