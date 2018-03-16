-- APIs
-- numAccountMacros, numCharacterMacros = GetNumMacros()
-- CreateMacro(name, iconFileName, body, perCharacter)
-- DeleteMacro(index) or DeleteMacro("name")
-- name, texture, body = GetMacroInfo(index) or GetMacroInfo("name")
-- newIndex = EditMacro(index, "name", "iconTexture", "body")
local macroName,macroBody

function CreateNewMacro(macroName, macroBody, char, silent, overwrite)
   if overwrite and GetMacroInfo(macroName) then
      DeleteMacro(macroName)
      CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macroBody, char)
   elseif not overwrite and not GetMacroInfo(macroName) then
      CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macroBody, char)
   elseif overwrite and not GetMacroInfo(macroName) then
      CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macroBody, char)
   end

   if not silent then
      print("|cffff6000Handlium:|r Macro |cff3399FF"..macroName.."|r has been created.")
   end
end

--/run local function macro(name) if GetMacroInfo(name) then DeleteMacro(name) else CreateMacro("name","INV_MISC_QUESTIONMARK","boo",1) end; macro("bal1");
function ApplyMyMacros()
   local class = select(2, UnitClass("player"))
   local specName = select(2, GetSpecializationInfo(GetSpecialization())) or "None"

   --Basic Macros GLOBAL
   CreateNewMacro("HS","/use [mod:Shift]Garrison Hearthstone;[mod:alt]Dalaran Hearthstone; [nomod]Hearthstone",nil,true,false)
   CreateNewMacro("Cork","/click CorkFrame",nil,true,false)

   if class == "DRUID" then
      CreateNewMacro("Bal1","/castsequence reset=120 Moonfire, Sunfire",1,true,false)
   elseif class == "MAGE" then
   elseif class == "PRIEST" then
      if specName == "Discipline" then
         CreateNewMacro("Smite","/cast [mod:shift]Plea;[nomod]Smite",1,false,false)
      end
   elseif class == "SHAMAN" then
      -- For all specs
      CreateNewMacro("CC",[[#showtooltip
/focus [target=mouseover,exists]; target
/cast [@focus]Hex]],1,true,false)
      CreateNewMacro("Interupt",[[/stopcasting
/cast [@focus,exists][@target] Wind Shear]],1,true,false)

      if specName == "Elemental" then -- using multiline stringing
         CreateNewMacro("Shocks",[[#showtooltip
/cast [mod:shift] Earth Shock;[mod:ctrl]Wind Shear;[mod:altl]Frost Shock; Flame Shock]],1,true,false)
         CreateNewMacro("LavaBurst",[[#showtooltip
/cast [mod:shift]Totem Mastery;[mod:alt]Wind Shear;Lava Burst]],1,true,false)
         CreateNewMacro("LightningBolt",[[#showtooltip
/cast [mod:shift]Chain Lightning; Lightning Bolt]],1,true,false)
         CreateNewMacro("AoE",[[#showtooltip
/cast [mod:shift]Earthquake; Thunderstorm]],1,true,false)
         CreateNewMacro("StormAscend",[[#showtooltip
/cast [mod:shift]Ascendance; Stormkeeper]],1,true,false)
         CreateNewMacro("Totems1",[[#showtooltip
/cast [mod:shift]Liquid Magma Totem;Wind Rush Totem]],1,true,false)
         CreateNewMacro("SlowTotems",[[#showtooltip
/cast [mod:shift]Earthbind Totem;Lightning Surge Totem]],1,true,false)
         CreateNewMacro("Elementals",[[#showtooltip
/cast [mod:shift]Fire Elemental;Earth Elemental]],1,true,false)

      end
   elseif class == "WARLOCK" then
   elseif class == "PALADIN" then
   elseif class == "MONK" then
   end
end
