# Astrosmash Clone
A clone of the Intellivision game Astrosmash, written in Ruby 2.1.2 using Gosu as the game engine.

![Screenshot](http://i.imgur.com/HzDA3MU.png "Screenshot")

Instructions
--------
- Ensure you have Ruby 2.1.2 and the [Gosu](http://www.libgosu.org/) gem installed.
- Clone the repo, cd into the directory and make game.rb excutable (`chmod +x ./game.rb`)
- Execute game.rb!

Controls
--------
- Arrow Left / Right = Move Left / Right
- Space = Start Game / Fire
- Left Shift = Hyperspace (warp)
- R = Reset Game
- P = Pause Game
- Esc = Quit

| Multiplier |   Score Range   |
|------------|:---------------:|
|     1x     |     0 - 999     |
|     2x     |  1,000 - 4,999  |
|     3x     |  5,000 - 19,999 |
|     4x     | 20,000 - 49,999 |
|     5x     | 50,000 - 49,999 |
|     6x     |     100,000+    |

Extra life every 5,000 points. Difficulty increases with the score multiplier, and every 100k starting at 200k points.

To-Do
--------
- Proper graphics for title/hud/score/ect instead of drawing fonts
- Add sounds/audio
- ~~Implement hyperspace jumping~~
- ~~Implement more enemy types (UFOs, Spinners, Homing Missiles)~~
- ~~Implement "levels" at scoring breakpoints~~ (score multiplier is working w/ background color change)
- ~~Implement additional lives at scoring breakpoints~~