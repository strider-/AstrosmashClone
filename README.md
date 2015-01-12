# Astrosmash Clone
A clone of the Intellivision game Astrosmash, written in Ruby 2.1.2 using Gosu as the game engine.

![Screenshot](http://i.imgur.com/l50k6ae.png "Screenshot")

Controls
--------
- Arrow Left / Right = Move Left / Right
- Space = Start Game / Fire
- Left Shift = Hyperspace (warp)
- R = Reset Game
- Esc = Quit

| Multiplier |   Score Range   |
|------------|:---------------:|
|     1x     |     0 - 999     |
|     2x     |  1,000 - 4,999  |
|     3x     |  5,000 - 19,999 |
|     4x     | 20,000 - 49,999 |
|     5x     | 50,000 - 49,999 |
|     6x     |     100,000+    |

Extra life every 1000 points

To-Do
--------
- Proper graphics for title/hud/score/ect instead of drawing fonts
- Add sounds/audio
- ~~Implement hyperspace jumping~~
- Implement more enemy types (UFOs, Spinners, Homing Missles)
- Implement "levels" at scoring breakpoints (score multiplier is working)
- ~~Implement additional lives at scoring breakpoints~~