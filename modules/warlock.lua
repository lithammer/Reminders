local addonName, addon = ...
local config = addon.config.warlock

if config.enabled and addon.playerClass == "WARLOCK" then
	local hasDemon = function()
		local hasPetSpells, petType = HasPetSpells()
		return hasPetSpells and petType == "DEMON"
	end

	addon:AddReminder("Missing Demon Skin", function()
		return not AuraUtil.FindAuraByName("Demon Skin", "player")
	end, {type = "spell", spell = "Demon Skin"})

	addon:AddReminder("Missing Soul Link", function()
		return not (AuraUtil.FindAuraByName("Soul Link", "player") or AuraUtil.FindAuraByName("Grimoire of Sacrifice", "player")) and hasDemon() and addon:HasTalent(2, 16)
	end, {type = "spell", spell = "Soul Link"})
end
