#!/bin/sh

# Check if a program exists in path
function ahave() {
  unset -v ahave; command command type $1 &> /dev/null && ahave="yes" || return 1;
}

# Check if help has been called
function ahelp() {
  unset -v ahelp; [[ "$#" -gt "0" ]] && [[ "$1" == "-h" || "$1" == "--h" || "$1" == "--help" || "$1" == "-help" || "$1" == "-?" ]] && ahelp="yes";
}

# Pretty print PATH
path() {
echo $PATH | tr ":" "\n" | \
awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
       sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
       sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
       sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
       sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
       print }"
}

# Make vim a pager
function vless() {
  [[ $# -eq 0 ]] && command vim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim' -
  [[ $# -eq 0 ]] || command vim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim' "$@"
}

# Use vim as man viewer
function vman() {
  env PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nolist nonumber' -c 'map q :q<CR>' \
  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}

# Recursively search directory tree for string (exclude hidden directories)
function findg() {
  [[ "$#" -lt "2" ]] && echo "usage: $0 <find_dir> <grep_token>" >&2 && return 2
  find $1 \( ! -regex '.*/\..*/..*' \) -type f -print0 | xargs -0 grep $2
}

# Save and restore location
s() { pwd > ~/.save_dir ; }
i() { cd "`cat ~/.save_dir`" ; }

# Extract compress files
function ex() {
  [[ "$#" -gt "0" && $1 == *-h* ]] && ahelp $1 && echo "usage: $0 <compressed_file>" && return 2
  until [[ -z "$1" ]]; do
    if [[ -f "$1" ]] ; then
      echo "Extracting $1..."
      case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.tar.xz) tar xvJf $1;;
        *.tar.lzma) tar --lzma xvf $1;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.dmg) hdiutul mount $1;; # mount OS X disk images
        *) echo "'$1' cannot be extracted via >ex<";;
      esac;
    else
      echo "'$1' is not a valid file"
    fi
    shift
  done
}

# My IP address
function myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0: " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# Run a command detached from the terminal and w/o output
function nh() {
  [[ "$#" -lt "1" ]] && echo "usage: $0 <command>" >&2 && return 2
  nohup "$@" &>/dev/null & echo;
}

# Output every dir in the current directory, and how many files each contains
function wcdir() {
  [[ "$#" -gt "0" && $1 == *-h* ]] && ahelp $1 && echo "usage: $0" && return 2
  find ${1:-.} -mindepth 1 -type d -print0 | xargs -0 -iFF sh -c 'echo `find "FF"/ -type f 2>/dev/null|wc -l;echo "FF"`' | sort -n | sed -e 's/^\([0-9]*\) \(.*\)$/ \1\t\2/g'
}

# Grep process
function psgr() { ps aux | grep $1 | grep -v grep }

# Return number of processes
function pswc() { echo `command ps aux | wc -l` }

# Kill tmux session
function tmk() { tmux kill-session -t $1 }

# Go to gem directory
function gemdir() {
  [[ "$#" -lt "1" ]] && echo "usage: $0 <ruby_version>" >&2 && return 2
  rvm "$1"
  cd $(rvm gemdir)
  pwd
}

# Show hidden files (OS X specific)
function showh() {
  defaults write com.apple.Finder AppleShowAllFiles TRUE
  killall Finder
}

# Hide hidden files (OS X specific)
function hideh() {
  defaults write com.apple.Finder AppleShowAllFiles FALSE
  killall Finder
}
