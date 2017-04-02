# Minesweeper
[![Minesweeper](https://raw.githubusercontent.com/Rion96/Minesweeper/master/Minesweeper.PNG)](https://www.youtube.com/watch?v=S-aRmZ9pbBY)

Minesweeper for TempleOS.

Flags are implemented but since there's no middle click or Left+Right click combo in TempleOS, they only serve as a reminder on where the mines are and prevent you from accidently clicking on them.
My uncovering mechanism is a bit wonky and uncovers surrounding fields as though flags are placed already. So the game is a bit easier than normal Minesweeper in this state


# Starting the game

    Cd("T:");
    #include "Mine.HC.Z";
