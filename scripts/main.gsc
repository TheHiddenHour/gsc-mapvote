#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init() {
    level.mapSelectionSize = 4; // Amount of maps for the player to choose from 

    level initializeMapvote();
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for(;;) {
        level waittill("connected", player);

        player thread onPlayerSpawned();
    }
}

onPlayerSpawned() {
    self endon("disconnect");
    self endon("game_ended");

    for(;;) {
        self waittill("spawned_player");

        self thread playerMapvote();
    }
}

initializeMapvote() {
    level thread monitorMapvoteEndgame();

    if(!isFirstRoundOv()) {
        return;
    }

    map_array = createMapArray(); // Array of all possible maps to be chosen 
    level.selectableMaps = createSelectableMapArray(map_array, level.mapSelectionSize); // Array of chosen maps

    level.mapVotes = []; // Amount of votes each map has 
    for(i = 0; i < level.mapSelectionSize; i++) {
        level.mapVotes[i] = 0;
    }

    level.optionHuds = []; // Selectable map option HUDs 
    for(i = 0; i < level.mapSelectionSize; i++) {
        level.optionHuds[i] = level spawnServerText("default", level.selectableMaps[i] + ": " + level.mapVotes[i], 1.5, "RIGHT", "RIGHT", 0, -150 + (i * 24), (1, 1, 1), undefined, 1, undefined, 1);
    }

    level thread monitorMapvote();
}

monitorMapvoteEndgame() {
    level waittill("game_ended");
    if(wasLastRound()) {
        level waittill("final_killcam_done");
        most_voted_map = getDvar("mostvotedmap");
        changeMap(most_voted_map);
    }
}

monitorMapvote() {
    level waittill("prematch_over");

    // Destory every player's scroller hud 
    foreach(player in level.players) {
        player notify("end_player_mapvote"); // End player mapvote thread 
        if(isDefined(player.mapvoteScrollHud)) { // Destroy player mapvote scroller 
            player.mapvoteScrollHud destroy();
        }
    }

    foreach(option in level.optionHuds) { // Destroy server mapvote huds 
        option destroy();
    }

    most_voted_map = getMostVotedMapname(level.selectableMaps, level.mapVotes);
    setDvar("mostvotedmap", most_voted_map);
    allClientsPrint("^1" + most_voted_map + " ^7was the most voted map");
}

playerMapvote() {
    self endon("game_ended");
    self endon("disconnect");
    self endon("end_player_mapvote");

    if(!isFirstRoundOv() || !level.inprematchperiod) { // Only allow voting for first round's prematch period 
        return;
    }

    self iprintlnbold("[{+speed_throw}][{+attack}] to scroll, [{+usereload}] to select.");

    self.mapvoteScrollHud = self spawnClientShader("white", "RIGHT", "RIGHT", 0, -150, 125, 18, (0, 0, 1), 1, 0);
    self.mapvoteScrollIndex = 0;

    for(;;) {
        if(self adsButtonPressed()) { // Scroll up 
            if(self.mapvoteScrollIndex > 0) {
                self.mapvoteScrollIndex--;
            }
            else {
                self.mapvoteScrollIndex = level.mapSelectionSize - 1;
            }
            self.mapvoteScrollHud.y = -150 + (self.mapvoteScrollIndex * 24);

            wait .25;
        }
        else if(self attackButtonPressed()) { // Scroll down 
            if(self.mapvoteScrollIndex < level.mapSelectionSize - 1) {
                self.mapvoteScrollIndex++;
            }
            else {
                self.mapvoteScrollIndex = 0;
            }
            self.mapvoteScrollHud.y = -150 + (self.mapvoteScrollIndex * 24);

            wait .25;
        }
        else if(self useButtonPressed()) { // Select option 
            level.mapVotes[self.mapvoteScrollIndex]++;
            level.optionHuds[self.mapvoteScrollIndex] setText(level.selectableMaps[self.mapvoteScrollIndex] + ": " + level.mapVotes[self.mapvoteScrollIndex]);
            self.mapvoteScrollHud destroy();
            allClientsPrint(self.name + " voted for ^1" + level.selectableMaps[self.mapvoteScrollIndex]);
            return;
        }

        wait .01;
    }
}

getMostVotedMapname(mapArray, voteArray) {
    map_index = getMostVotedMapIndex(voteArray);
    return mapArray[map_index];
}

getMostVotedMapIndex(voteArray) {
    most_voted_index = 0;
    for(i = 0; i < voteArray.size; i++) {
        if(voteArray[i] > voteArray[most_voted_index]) {
            most_voted_index = i;
        }
    }

    return most_voted_index;
}

createSelectableMapArray(mapArray, amount) {
    selection = [];
    while(selection.size < amount) {
        index = randomInt(mapArray.size);
        mapname = mapArray[index];

        if(!isInArray(selection, mapname)) {
            selection[selection.size] = mapname;
        }
    }

    return selection;
}

createMapArray() {
    /*
        We could also tokenize the string and return the resulting array.
        Being able to easily comment out maps is nice, though.
    */
    map_arr = [];
	map_arr[map_arr.size] = "mp_la";
	map_arr[map_arr.size] = "mp_dockside";
	map_arr[map_arr.size] = "mp_carrier";
	map_arr[map_arr.size] = "mp_drone";
	map_arr[map_arr.size] = "mp_express";
	map_arr[map_arr.size] = "mp_hijacked";
	map_arr[map_arr.size] = "mp_meltdown";
	map_arr[map_arr.size] = "mp_overflow";
	map_arr[map_arr.size] = "mp_nightclub";
	map_arr[map_arr.size] = "mp_raid";
	map_arr[map_arr.size] = "mp_slums";
	map_arr[map_arr.size] = "mp_village";
	map_arr[map_arr.size] = "mp_turbine";
	map_arr[map_arr.size] = "mp_socotra";
	map_arr[map_arr.size] = "mp_nuketown_2020";
	/*map_arr[map_arr.size] = "mp_hydro";
	map_arr[map_arr.size] = "mp_skate";
	map_arr[map_arr.size] = "mp_downhill";
	map_arr[map_arr.size] = "mp_mirage";
	map_arr[map_arr.size] = "mp_concert";
	map_arr[map_arr.size] = "mp_magma";
	map_arr[map_arr.size] = "mp_studio";
	map_arr[map_arr.size] = "mp_vertigo";
	map_arr[map_arr.size] = "mp_cove";
	map_arr[map_arr.size] = "mp_detour";
	map_arr[map_arr.size] = "mp_paintball";
	map_arr[map_arr.size] = "mp_uplink";
	map_arr[map_arr.size] = "mp_dig";
	map_arr[map_arr.size] = "mp_frostbite";
	map_arr[map_arr.size] = "mp_pod";
	map_arr[map_arr.size] = "mp_takeoff";*/

    return map_arr;
}

isFirstRoundOv() { // Alternative function for isFirstRound() which doesn't seem to work 
    return game["roundsplayed"] == 0;
}

changeMap(map) {
    // Credits to TheNiceUb3r 
    setDvar("ls_mapname", map);
    setDvar("mapname", map);
    setDvar("party_mapname", map);
    setDvar("ui_mapname", map);
    setDvar("ui_currentMap", map);
    setDvar("ui_mapname", map);
    setDvar("ui_preview_map", map);
    setDvar("ui_showmap", map);
    map(map);
}