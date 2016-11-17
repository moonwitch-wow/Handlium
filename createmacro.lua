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
   end

   if not silent then
      print("Macro "..macroName.." has been created.")
   end
end


--/run local function macro(name) if GetMacroInfo(name) then DeleteMacro(name) else CreateMacro("name","INV_MISC_QUESTIONMARK","boo",1) end; macro("bal1");
function ApplyMyMacros()
   local _, class = UnitClass("player")
   local _, race = UnitRace("player")
   local curSpec = GetSpecialization()
   local specName = curSpec and select(2, GetSpecializationInfo(curSpec)) or "None"

   --Basic Macros GLOBAL
   CreateNewMacro("HS","/use [mod:Shift]Garrison Hearthstone;[mod:alt]Dalaran Hearthstone; [nomod]Hearthstone",nil,false,false)

   if class == "DRUID" then
      CreateNewMacro("Bal1","/castsequence reset=120 Moonfire, Sunfire",1,true)
   elseif class == "MAGE" then
   elseif class == "PRIEST" then
   elseif class == "SHAMAN" then
   elseif class == "WARLOCK" then
   elseif class == "PALADIN" then
   elseif class == "MONK" then
   end
end
