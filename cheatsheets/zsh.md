# zsh | cheatsheet
[home](../readme.md)

## Basic Commands
What you need to know to use ZSH.

*Hint*: Zsh is mostly backwards compatabile with Bash, so most Bash commands work in Zsh also.

| Command | Example | Description |
| --- | --- | --- |
| *cmd*  | Executes *cmd* |
| *cmd* & | ls & | Starts *cmd* as a background process |

## Conditional execution

| Command | Example | Description |
| --- | --- | --- |
| && | git commit && git push | Run the first command, and if it succeeds, run the following command. |
| \|\| | git commit \|\| echo "Commit failed" | If the first command fails, run the second. |

## Variables

| Command | Example | Description |
| --- | --- | --- |
| *var*=*value* | NAME="Phil" | Set *var* to *value* in the session (the script or terminal) |
| $*var* or "$*var*" or "${*var*}" | echo $NAME "$NAME" "${NAME}" | Returns the value of the variable *var* |
| $(*cmd*) | echo "My location: $(pwd)" | Executes *cmd* and returns the result. |
| vared *var* | vared NAME | Edit the variable *var* in-line |

## Replacements & Expansions
Some expressions are simply stand-ins that are replaced by other values.

| Expression | Example | Description |
| --- | --- | --- |
| !! | sudo !! | replaced with last command (sudo ls) |
| !* | ls !* | replaced with last command's parameters (ls -l -a) |
| !^ | ls !^ | replaced with last command's first parameter (ls -l) |
| !$ | ls !$ | replaced with last command's last parameter (ls -a) |
| !*str* | !l | replaced with last command beginning with *str* (ls -a) |
| !?*str* | !?udo | replaced with last command containing *str* (sudo ls) |

## Recommendations
It seems like these days zsh has become zsh + oh-my-zsh. I recommend you at least try it out [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), it has some nice benefits over the basic terminal.