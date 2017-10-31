# vim | cheatsheet
[home](../readme.md)

## Basic Commands

### Movement

| | | |
| --- | -- | --- |
| h l k j | | character left, right; line up, down |
| b w | | word left, right|
| ge e | | end of word left, right |
| { } | | beginning of previous, next paragraph |
| ( ) | | beginning of previous, next sentence |
| 0 gm | | beginning of line (hard), middle of line |
| ^ $ | | first, last character of line (soft) |
| *n*% | | *n*% down the file from the top |
| *n*H *n*L | | line *n* from top, bottom of window 

### Editing
| | | |
| --- | --- | --- |
| i a | | insert before, after cursor |
| I A | | insert at beginning, end of line | 
| o O | | edit new line below, above current line |
| r*c* | | replace character under cursor with *c* |
| R | | Replace characters, starting at cursor |
| c*m* | | change text of movement *m* |
| cc S | | change current line |
| C | | change to end of line |
| ~ | | switch case of character under cursor and advance |

## Operators

## Misc

### Folds

| | |
|---------|-------|
| zo / zO | Open  |
| zc / zC | Close |
|         |       |
|         |       |