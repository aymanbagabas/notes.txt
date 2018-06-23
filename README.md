# notes.txt
A todo.txt inspired project to manage your notes with your favorite text editor.
Use your favorite text editor with your preferred format like markdown, asciidoc, or pure text.

## Installation
Optional: install tree for better file listing.

```
git clone https://github.com/aymanbagabas/notes.txt.git && cd notes.txt && sudo make install && cp -f notes.cfg ~/.notes.cfg
```

## Usage
Usage: note.sh action [NAME]

Actions:
    new | n "NOTEBOOK"
    add | a "NOTENAME"
    edit | e "NOTENAME"
    delete | remove | del | rm "NOTENAME"
    list | ls

## Configuration
Notes.sh reads configuration from `$HOME/.notes.cfg`
```
NOTES_DIR - notes storage directory, default is $HOME/.notes
EDITOR - text editor to use, if not defined uses enviroment definetion or defaults to GNU nano.
```

## TODO:
1. Add output colors.
2. ~~Support config file.~~
3. Autocompletion
4. File information: date of creation, last modified, etc.
5. ~~Creation date with new notes.~~
6. Support for external actions.
7. Testing
