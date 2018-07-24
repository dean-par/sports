# Sports App
This is an app showing the stats of players of a match. On the main page, the list of the two teams' top players are listed.
Tapping on the image of the player will bring you to a more detailed page of that particular player's stats of their last game. This will show stats such as goals, kicks, offsides, etc.

# Endpoint Issues
The endpoint for downloading the images and the default image was not working. So I have just downloaded a random default image from the internet and have set it as the image of the players.

# Scope Reduction
For the sake of delivering the project in a timely manner, I have not placed importance on error handling scenarios.

# Improvements
1. If more time allowed, the Network Manager should be iplemented in a protocol oriented way. It would be easier to use by conforming to the protocol and specifying the endpoints. Whereas the current implementation requires the developer to change the NetworkManager and Configuration classes which is less intuitive.
2. The image for the headshot is always being downloaded when it doesn't have to be. Caching of the image network call should be implemented (to once a day perhaps) which will save loading time and making numerours backend calls.
