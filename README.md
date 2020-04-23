# GSC Mapvote
GSC mapvote system for Call of Duty: Black Ops II.

* Does not use map shaders, only server text to display map names (mp_raid for ex.).
* Mapvote only executes on the first round of the match.
* Players are only allowed to vote if they spawn during prematch, not if they join mid-game.
* Map automatically changes at the end of killcam.
* Prone debug binds for exiting level and restarting map.

## Bugs 
* Players will sometimes spawn in the middle of the map and be unable to move. This usually occurs after the very first map change, but may happen multiple times. It can be fixed by restarting the map.

## Notes
* Tested on a CFW PlayStation 3.
* Developed using personal tools but the `scripts` directory should compile in GSC Studio.