local addonName, addon = ...
local config = addon.config.monk

if config.enabled and addon.playerClass == "MONK" then
	local IsWindwalker = function()
		return GetSpecialization() == 3
	end

	addon:AddReminder("Missing Legacy of the Emperor", function() return not addon:HasStatsBuff() end, {type = "spell", spell = "Legacy of the Emperor"})
	addon:AddReminder("Missing Legacy of the White Tiger", function() return IsWindwalker() and not addon:HasMasteryBuff() end, {type = "spell", spell = "Legacy of the White Tiger"})
end
