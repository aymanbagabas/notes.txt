#!/bin/bash

# Settings
CFG="$HOME/.notes.cfg"
[ -e "$CFG" ] && . "$CFG"
[ -z "$NOTES_DIR" ] && NOTES_DIR="$HOME/.notes"
DEFAULT_EXT=".txt"
# Set default $EDITOR
[ -z "$EDITOR" ] && EDITOR=nano

# Initiate notes dir
if [ ! -e "$NOTES_DIR" ]; then
    mkdir -p "$NOTES_DIR"
    echo "Notes directory \"$NOTES_DIR\" has been created!"
fi

# Define functions

usage() {
    cat <<USAGE
Usage: note.sh action [note_number]

Actions:
    new | n "NOTEBOOK"
    add | a "NOTENAME"
    edit | e "NOTENAME"
    delete | remove | del | rm "NOTENAME"
    list | ls

USAGE
    exit 1
}

list() {
    if [ "`which tree`" ]; then
        tree -D "$NOTES_DIR"
    else
        ls --color -tR "$NOTES_DIR"
    fi
}

new() {
    ARG="$NOTES_DIR/$1"
    if [ -e $ARG ]; then
        echo "Notebook already exists!"
        exit 1
    else
        mkdir -p $ARG
        echo "Notebook \"$1\" has been created."
    fi
}

_fileext() {
    # File extension
    FILE=$NOTES_DIR/$1
    if [ "${1##*.}" == "$1" ]; then
        FILE=$FILE$DEFAULT_EXT
    fi
}

add() {
    _fileext $1
    if [ -e "$FILE" ]; then
        echo "File already exists!"
        exit 1
    else
        # In case if directory does not exist
        case "$1" in
            */*)
                DIR=${1%/*}
                if [ ! -d "$NOTES_DIR/$DIR" ]; then
                    mkdir -p "$NOTES_DIR/$DIR"
                    echo "Notebook \"$DIR\" has been created."
                fi
                ;;
        esac
        echo -e "---\nDate Created: `date +'%Y-%m-%d'`\n---\n" > "$FILE"
        echo "Note \"$FILE\" has been created!"
    fi
}

edit() {
    _fileext $1
    [ ! -e "$FILE" ] && add "$1"
    $EDITOR "$FILE"
}

delete() {
    FILE="$NOTES_DIR/$1"
    if [ -d $FILE ]; then
        echo -n "Remove notebook \"$1\"? (y/N): "
        read y
        if [ $y == "y" -o $y == "Y" ]; then
            rm -rf $FILE
            echo "Notebook \"$1\" removed!"
        else
            echo "Abort!"
        fi
    else
        echo -n "Remove note \"$1\"? (y/N): "
        read y
        if [ $y == "y" -o $y == "Y" ]; then
            rm $FILE
            echo "\"$1\" removed."
        else
            "Abort!"
        fi
    fi
}

# Main
case "$1" in
    "ls"|"list")
        list
        ;;
    "e"|"edit"|"o"|"open")
        edit $2
        ;;
    "n"|"new")
        new $2
        ;;
    "a"|"add")
        add $2
        ;;
    "del"|"rm"|"delete"|"remove")
        delete $2
        ;;
    *)
        usage
esac

