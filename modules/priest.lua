local addonName, addon = ...
local config = addon.config.priest

if config.enabled and addon.playerClass == "PRIEST" then
	addon:AddReminder("Missing Power Word: Fortitude", function() return not addon:HasStaminaBuff() end, {type = "spell", unit = "player", spell = "Power Word: Fortitude"})
	addon:AddReminder("Missing Inner Fire/Will", function() return not addon:HasAnyAura({"Inner Fire", "Inner Will"}) end, {type = "spell", spell1 = "Inner Fire", spell2 = "Inner Will"})
end
