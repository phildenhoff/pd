# Openbox

## Shortcut commands

Openbox is best used with a TON of shortcuts. I mean, it doesn't have much of
a GUI so you pretty well just have to.

### Default Shortcuts

### Custom Shortcuts

| Keybind | Action |
| Meta + Alt + D | Toggle Menubar decoration. |
| Meta + F2 | Display lock screen. |
| Meta + Left | Move window to left have of display. |
| Meta + Right | Move window to right half of display. |
| Meta + Up | Maximise Window |
| Meta + Down | Minimize window. |

### Backlight

This is awful. I feel bad about this hack - and I fear in the future it may affect my install. That said, I would like to actually change the brightness of my screen, so I did this.

First, I changed the group of `/sys/class/backlight/intel_backlight/brightness` to `phil` (my user group). I then changed the permissions of the files to `664` so my group had write access.

Then, changing brightness is easy, given *num* some number between 0 and max_brightness (937):

``` bash
tee /sys/class/backlight/intel_backlight/brightness <<< *num*
```


