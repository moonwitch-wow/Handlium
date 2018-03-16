------------------------------------------------------------------------
-- Localizing and loading the addon DB
------------------------------------------------------------------------
local _, Handlium = ...
local bindFrame = CreateFrame("Frame")
local handler = CreateFrame("Frame")

------------------------------------------------------------------------
-- Basic Bindings
------------------------------------------------------------------------
local function ApplyMyBindings(silent)
  ClearAllBindings() -- Since we're hardwiring these; no need to keep some ;P
  -- Movement
  SetBinding("W", "MOVEFORWARD")
  SetBinding("SHIFT-W", "TOGGLEAUTORUN")
  SetBinding("S", "MOVEBACKWARD")
  SetBinding("SHIFT-S", "SITORSTAND")
  SetBinding("A", "STRAFELEFT")
  SetBinding("SHIFT-A", "TURNLEFT")
  SetBinding("D", "STRAFERIGHT")
  SetBinding("SHIFT-D", "TURNRIGHT")
  SetBinding("SPACE", "JUMP")

  -- Chat
  SetBinding("ENTER", "OPENCHAT")
  SetBinding("/", "OPENCHATSLASH")
  SetBinding("SHIFT-R", "REPLY")

  -- ActionPages
  SetBinding("SHIFT-UP", "PREVIOUSACTIONPAGE")
  SetBinding("SHIFT-MOUSEWHEELUP", "PREVIOUSACTIONPAGE")
  SetBinding("SHIFT-DOWN", "NEXTACTIONPAGE")
  SetBinding("SHIFT-MOUSEWHEELDOWN", "NEXTACTIONPAGE")

  -- Targeting
  SetBinding("TAB", "TARGETNEARESTENEMY")
  SetBinding("SHIFT-TAB", "TARGETNEARESTFRIEND")
  SetBinding("F2", "FOCUSTARGET")
  SetBinding("F3", "TARGETFOCUS")

  -- Attacking
  SetBinding("T", "STARTATTACK")
  SetBinding("SHIFT-T", "ASSISTTARGET")
  SetBinding("ALT-T", "INTERACTTARGET")

  -- UI Panels
  SetBinding("ESCAPE", "TOGGLEGAMEMENU")
  SetBinding("B", "OPENALLBAGS")
    -- Maps 'n Quests
  SetBinding("M", "TOGGLEWORLDMAP")
  SetBinding("SHIFT-M", "TOGGLEBATTLEFIELDMINIMAP")
  SetBinding("L", "TOGGLEQUESTLOG")
    -- Character
  SetBinding("F9", "TOGGLECHARACTER0")
  SetBinding("SHIFT-F9", "TOGGLESPELLBOOK")
  SetBinding("CTRL-F9",  "TOGGLETALENTS")
    -- Pets 'n mounts
  SetBinding("K", "TOGGLECOLLECTIONS")
  SetBinding("SHIFT-K", "TOGGLECOLLECTIONSMOUNTJOURNAL")
  SetBinding("O", "TOGGLESOCIAL")
  SetBinding("SHIFT-O", "TOGGLEGUILDTAB")

  SetBinding("F11", "TOGGLEDUNGEONSANDRAIDS") --groupfinder
  SetBinding("SHIFT-F11", "TOGGLEENCOUNTERJOURNAL")
  SetBinding("ALT-F11", "TOGGLEGARRISONREPORT")

  -- UI Toggles
  -- SetBinding("ALT-Z", "TOGGLEUI")
  -- SetBinding("CTRL-R", "TOGGLEFPS")

  -- Camera
  SetBinding("MOUSEWHEELUP", "CAMERAZOOMIN")
  SetBinding("MOUSEWHEELDOWN", "CAMERAZOOMOUT")

  -- -- Vehicle Aim
  -- SetBinding("CTRL-MOUSEWHEELUP", "VEHICLEAIMUP")
  -- SetBinding("CTRL-MOUSEWHEELDOWN", "VEHICLEAIMDOWN")

  -- Addons
  SetBinding("CTRL-V", "DISMOUNT") -- Using an addon that hijacks DISMOUNT
  SetBinding("F12", "CLICK CorkFrame:LeftButton")
  SetBinding("SHIFT-F", "SPELL Survey")
  SetBinding("CTRL-F", "ITEM Deadly Iron Trap")

  -- Trinkets
  SetBinding("X", "MACRO trinkets")

  if not silent then
    print("Bindings applied.")
  end
end

local function ApplyMyOverrideBindings(silent)
  local _, class = UnitClass("player")
  local _, race = UnitRace("player")
  local curSpec = GetSpecialization()
  local specName = curSpec and select(2, GetSpecializationInfo(curSpec)) or "None"
  local ob = {
    -- ["ALT-Q"] = "MACRO QuestItem",
    -- ["ALT-`"] = "ITEM Hearthstone",
  }

  -- [[ Druid Bindings ]] --
  if class == "DRUID" then
    ob["Q"] = "SPELL Running Wild"
    ob["E"] = "SPELL Darkflight" -- Worgen biatches

    -- Shapeshift Forms
    ob["SHIFT-F1"] = "SPELL Bear Form"
    ob["SHIFT-F2"] = "SPELL Cat Form"
    ob["SHIFT-F3"] = "SPELL Travel Form"
    ob["SHIFT-F4"] = "SPELL Flight Form"

    -- [[ Mage Bindings ]] --
  elseif class == "MAGE" then
    -- Base
    ob["Q"] = "SPELL Greater Invisibility"
    ob["T"] = "SPELL Blink"
    ob["C"] = "SPELL Icy Veins"
    ob["F"] = "SPELL Counterspell"
    ob["H"] = "SPELL Spellsteal"
    ob["SHIFT-X"] = "SPELL Evocation"
    ob["§"] = "MACRO Bomb"

    ob["SHIFT-§"] = "SPELL Amplify Magic"
    ob["SHIFT-Q"] = "SPELL Ice Block"
    ob["SHIFT-R"] = "SPELL Presence of Mind"
    if specName == 'Arcane' then

    elseif specName == 'Frost' then

    end

    -- [[ Monk Bindings ]] --
  elseif class == "MONK" then
    ob["Q"] = "SPELL Roll"

    -- [[ Priest Bindings ]] --
  elseif class == "PRIEST" then
    ob["Q"] = "MACRO Pr01"
    ob["G"] = "SPELL Fade"
    ob["E"] = "SPELL Mass Dispel"
    ob["F"] = "SPELL Power Word: Barrier"
    ob["SHIFT-F"] = "SPELL Clarity of Will"

    ob["SHIFT-C"] = "SPELL Psychic Scream"
    ob["SHIFT-G"] = "MACRO /cast [@mouseover,help,nodead][@player] Leap of Faith"
    ob["SHIFT-H"] = "MACRO /stopcasting /cast Silence"
    ob["ALT-G"] = "MACRO /cast [@mouseover,help,nodead][@player] Levitate"

    -- Shadow
    if specName == "Shadow" then
    ob["SHIFT-X"] = "SPELL Shadow Word: Death"
    ob["|"] = "SPELL Shadowform"

    -- Disc
    -- ob["H"] = "SPELL Power Word: Barrier"
    -- ob["T"] = "MACRO /cast [@mouseover] Void Shift"
    -- ob["X"] = "SPELL Archangel"
    -- ob["Z"] = "MACRO /cast [@mouseover] Pain Suppression"

    -- ob["SHIFT-X"] = "SPELL Spirit Shell"
    -- ob["SHIFT-H"] = "SPELL LoF"
    end
    -- [[ Shaman Bindings ]] --
  elseif class == "SHAMAN" then
    -- base
    ob["Q"] = "MACRO Interupt"
    ob["SHIFT-Q"] = "MACRO CC"
    ob["E"] = "SPELL Astral Shift"
    ob["G"] = "SPELL Ascendance"
    ob["U"] = "SPELL Far Sight"

      -- Since I rebind my F keys ..
    ob["§"] = "FOCUSTARGET"
    ob["SHIFT-§"] = "TARGETFOCUS"

    -- Elemental
    if specName == "Elemental" then
      ob["F"] = "SPELL Shamanistic Rage"

      ob["CTRL-F1"] = "SPELL Fire Elemental Totem"
      ob["CTRL-F2"] = "SPELL Earth Elemental Totem"

      ob["ALT-F2"] = "SPELL Earthgrab Totem"
      ob["SHIFT-Q"] = "SPELL Gift of the Naaru"
    elseif specName == "Restoration" then
      ob["V"] = "SPELL Water Shield"
      ob["SHIFT-V"] = "SPELL Lightning Shield"

      ob["Q"] = "MACRO NO"
      ob["SHIFT-Q"] = "SPELL Elemental Blast"

      ob["F1"] = "SPELL Searing Totem"
      ob["F2"] = "SPELL Spirit Link Totem"
      ob["F3"] = "SPELL Healing Stream Totem"
      ob["F4"] = "SPELL Windwalk Totem"

      ob["CTRL-F1"] = "SPELL Fire Elemental Totem"
      ob["CTRL-F2"] = "SPELL Earth Elemental Totem"
      ob["CTRL-F3"] = "SPELL Healing Tide Totem"
      ob["CTRL-F4"] = "SPELL Capacitor Totem"

      ob["SHIFT-F1"] = "SPELL Totemic Recall"
      ob["SHIFT-F2"] = "SPELL Totemic Projection"
    end

  elseif class == "WARLOCK" then
    ob["Q"] = "SPELL Life Tap"

  end

  for key, action in pairs(ob) do
    SetOverrideBinding(bindFrame, false, key, action)
  end

  if not silent then
    print("Override bindings applied.")
    print("Active Spec is " .. specName)
  end
end

local function ApplyDefaultActionBindings(full, silent)
  SetBinding("1", "ACTIONBUTTON1")
  SetBinding("2", "ACTIONBUTTON2")
  SetBinding("3", "ACTIONBUTTON3")
  SetBinding("4", "ACTIONBUTTON4")
  SetBinding("5", "ACTIONBUTTON5")
  SetBinding("6", "ACTIONBUTTON6")
  SetBinding("7", "ACTIONBUTTON7")
  SetBinding("8", "ACTIONBUTTON8")

  -- Ensuring my Shift Macro's work, so this UNbinds the shifties.
  SetBinding("SHIFT-1")
  SetBinding("SHIFT-2")
  SetBinding("SHIFT-3")
  SetBinding("SHIFT-4")
  SetBinding("SHIFT-5")
  SetBinding("SHIFT-6")
  SetBinding("SHIFT-7")
  SetBinding("SHIFT-8")
  SetBinding("SHIFT-9")
  SetBinding("SHIFT-0")
  SetBinding("SHIFT--")
  SetBinding("SHIFT-=")

  if not full then
    if not silent then
      print("Bindings applied for action buttons 1-8.")
    end
    return
  end

  SetBinding("9", "ACTIONBUTTON9")
  SetBinding("0", "ACTIONBUTTON10")
  SetBinding("-", "ACTIONBUTTON11")
  SetBinding("=", "ACTIONBUTTON12")

  if not silent then
    print("Bindings applied for action buttons 1-12.")
  end
end

SetBinding("ESCAPE", "TOGGLEGAMEMENU")
SetBinding("/", "OPENCHATSLASH")



------------------------------------------------------------------------
--  ClearAllBindings()
--    Removes all bindings, and then applies the following bindings:
--      [1] ESC -> Toggle main menu
--      [2] / -> Open chat input box with a pre-filled slash
------------------------------------------------------------------------
function ClearAllBindings()
  for i = 1, GetNumBindings() do
    for j = select( "#", GetBinding( i ) ), 2, -1 do
      local b = select( j, GetBinding( i ) )
      if b then
        SetBinding( b )
      end
    end
  end
  SetBinding( "ESCAPE", "TOGGLEGAMEMENU" )
  SetBinding( "/", "OPENCHATSLASH" )
end

------------------------------------------------------------------------
-- Voltron Assemble
------------------------------------------------------------------------
function Handlium.PLAYER_ENTERING_WORLD(...)
  SystemFont_Shadow_Small:SetFont(STANDARD_TEXT_FONT, 12) -- changing the macro font, it's too damn small
  ApplyMyBindings(true)
  ApplyMyOverrideBindings(true)
  ApplyDefaultActionBindings(nil, true)
  SaveBindings(1) -- 1: Account Wide, 2: Character Wide
  ApplyMyMacros()
end

function Handlium.ACTIVE_TALENT_GROUP_CHANGED(...)
  ApplyMyOverrideBindings(false)
  print("Changed bindings for spec")
end

handler:SetScript("OnEvent", function(self, event, ...)
  Handlium[event](self, ...); -- call one of the functions above
  end)

for k, v in pairs(Handlium) do
  handler:RegisterEvent(k)
end
