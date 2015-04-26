local addonName, addon = ...
local config = addon.config.priest

if config.enabled and addon.playerClass == "PRIEST" then
	addon:AddReminder("Missing Power Word: Fortitude", function() return not addon:HasStaminaBuff() end, {type = "spell", unit = "player", spell = "Power Word: Fortitude"})
end
