local addonName, addon = ...
local config = addon.config.rogue

if config.enabled and addon.playerClass == "ROGUE" then
	addon:AddReminder("Main hand poison", function() return not addon:HasAnyAura(config.mainHandPoisons) end, {type = "spell", spell1 = config.mainHandPoisons[1], spell2 = config.mainHandPoisons[2], threshold = config.thresholdTime})
	addon:AddReminder("Off hand poison", function() return not addon:HasAnyAura(config.offHandPoisons) end, {type = "spell", spell1 = config.offHandPoisons[1], spell2 = config.offHandPoisons[2], threshold = config.thresholdTime})
end
