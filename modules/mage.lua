local addonName, addon = ...
local config = addon.config.mage

if config.enabled and addon.playerClass == "MAGE" then
	if GetSpellBookItemInfo("Dalaran Brilliance") then
		addon:AddReminder("Missing Dalaran/Arcane Brilliance", function()
			return not addon:HasSpellPowerBuff()
		end , {type = "spell", spell1 = "Dalaran Brilliance", spell2 = "Arcane Brilliance"})
	else
		addon:AddReminder("Missing Arcane Brilliance", function() return
			not addon:HasSpellPowerBuff()
		end, {type = "spell", spell = "Arcane Brilliance"})
	end
end
