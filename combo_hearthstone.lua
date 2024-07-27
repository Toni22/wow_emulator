--[==[
    = How to add new locations =
    Example:
    The first line will be the main menu ID (Here [1], 
    increment this for each main menu option!),
    the main menu gossip title (Here "Horde Cities"),
    as well as which faction can use the said menu (Here 1 (Horde)). 
    0 = Alliance, 1 = Horde, 2 = Both
    The second line is the name of the main menu's sub menus, 
    separated by name (Here "Orgrimmar") and teleport coordinates
    using Map, X, Y, Z, O (Here 1, 1503, -4415.5, 22, 0)
    [1] = { "Horde Cities", 1,    --  This will be the main menu title, as well as which faction can use the said menu. 0 = Alliance, 1 = Horde, 2 = Both
        {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
    },
    You can copy paste the above into the script and change the values as informed.
]==]

local ItemEntry = 6948

local T = {
    [1] = { "Städte der Horde", 1,
        {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
        {"Unterstadt", 0, 1831, 238.5, 61.6, 0},
        {"Donnerfels", 1, -1278, 122, 132, 0},
        {"Silbermond", 530, 9484, -7294, 15, 0},
    },
    [2] = { "Städte der Allianz", 0,
        {"Sturmwind", 0, -8905, 560, 94, 0.62},
        {"Eisenschmiede", 0, -4795, -1117, 499, 0},
        {"Darnassus", 1, 9952, 2280.5, 1342, 1.6},
        {"Exodar", 530, -3863, -11736, -106, 2},
    },
    [3] = { "Gebiete der Scherbenwelt", 2,
        {"Schergrat", 530, 1481, 6829, 107, 6},
        {"Höllenfeuerhalbinsel", 530, -249, 947, 85, 2},
        {"Nagrand", 530, -1769, 7150, -9, 2},
        {"Nethersturm", 530, 3043, 3645, 143, 2},
        {"Schattenmondtal", 530, -3034, 2937, 87, 5},
        {"Wälder von Terokkar", 530, -1942, 4689, -2, 5},
        {"Zangarmarschen", 530, -217, 5488, 23, 2},
        {"Shattrath", 530, -1822, 5417, 1, 3},
    },
    [4] = { "Gebiete von Nordend", 2,
        {"Boreanische Tundra", 571, 3230, 5279, 47, 3},
        {"Kristallsangwald", 571, 5732, 1016, 175, 3.6},
        {"Drachenöde", 571, 3547, 274, 46, 1.6},
        {"Grizzlyhügel", 571, 3759, -2672, 177, 3},
        {"Heulender Fjord", 571, 772, -2905, 7, 5},
        {"Eiskronengletscher", 571, 8517, 676, 559, 4.7},
        {"Sholazar Becken", 571, 5571, 5739, -75, 2},
        {"Sturmgipfel", 571, 6121, -1025, 409, 4.7},
        {"Tausendwintersee", 571, 5135, 2840, 408, 3},
        {"Zul'Drak", 571, 5761, -3547, 387, 5},
        {"Dalaran", 571, 5826, 470, 659, 1.4},
    },
    [5] = { "PvP Gebiete", 2,
        {"Arena der Gurubashi", 0, -13229, 226, 33, 1},
        {"Düsterbruch Arena", 1, -3669, 1094, 160, 3},
        {"Arena von Nagrand", 530, -1983, 6562, 12, 2},
        {"Arena des Schergrats", 530, 2910, 5976, 2, 4},
    },
}

-- CODE STUFFS! DO NOT EDIT BELOW
-- UNLESS YOU KNOW WHAT YOU'RE DOING!

local function OnGossipHello(event, player, item)
    -- Show main menu
    for i, v in ipairs(T) do
        if (v[2] == 2 or v[2] == player:GetTeam()) then
            player:GossipMenuAddItem(0, v[1], i, 0)
        end
    end
    player:GossipSendMenu(1, item)
end    

local function OnGossipSelect(event, player, item, sender, intid, code)
    if (sender == 0) then
        -- return to main menu
        OnGossipHello(event, player, item)
        return
    end

    if (intid == 0) then
        -- Show teleport menu
        for i, v in ipairs(T[sender]) do
            if (i > 2) then
                player:GossipMenuAddItem(0, v[1], sender, i)
            end
        end
        player:GossipMenuAddItem(0, "Zurück...", 0, 0)
        player:GossipSendMenu(1, item)
        return
    else
        -- teleport
        local name, map, x, y, z, o = table.unpack(T[sender][intid])
        player:Teleport(map, x, y, z, o)
    end
    
    player:GossipComplete()
end

RegisterItemGossipEvent(ItemEntry, 1, OnGossipHello)
RegisterItemGossipEvent(ItemEntry, 2, OnGossipSelect)