local addonName, addon = ...
local config = addon.config.warlock

if config.enabled and addon.playerClass == "WARLOCK" then
	local hasDemon = function()
		local hasPetSpells, petType = HasPetSpells()
		return hasPetSpells and petType == "DEMON"
	end

	addon:AddReminder("Missing Dark Intent", function() return not addon:HasSpellPowerBuff() end, {type = "spell", spell = "Dark Intent"})
	addon:AddReminder("Missing Soul Link", function() return not addon:HasAnyAura("Soul Link") and hasDemon() and addon:HasTalent(7) end, {type = "spell", spell = "Soul Link"})
end

