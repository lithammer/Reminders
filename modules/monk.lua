local addonName, addon = ...
local config = addon.config.monk

if config.enabled and addon.playerClass == "MONK" then
	local IsWindwalker = function()
		return GetSpecialization() == 3
	end

	addon:AddReminder("Missing Legacy of the Emperor", function() return addon:MinPlayerLevel(22) and not addon:HasStatsBuff() end, {type = "spell", spell = "Legacy of the Emperor"})
	addon:AddReminder("Missing Legacy of the White Tiger", function() return addon:MinPlayerLevel(81) and IsWindwalker() and not addon:HasCriticalStrikeBuff() end, {type = "spell", spell = "Legacy of the White Tiger"})
end
