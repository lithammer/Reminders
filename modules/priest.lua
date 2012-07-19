local addonName, addon = ...
local config = addon.config.priest

if config.enabled and addon.playerClass == "PRIEST" then
	addon:AddReminder("Missing Power Word: Fortitude", function() return not addon:HasStaminaBuff() end, {type = "spell", unit = "player", spell = "Power Word: Fortitude"})
	addon:AddReminder("Missing Inner Fire/Will", function() return not addon:HasAnyAura(config.inners) end, {type = "spell", spell1 = config.inners[1], spell2 = config.inners[2]})
end
