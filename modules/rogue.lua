local addonName, addon = ...
local config = addon.config.rogue

if config.enabled and addon.playerClass == "ROGUE" then
	local mainHandTooltip, offHandTooltip = addon:GetWeaponEnchantTooltip(config.mainHandPoisons[1], config.mainHandPoisons[2]), addon:GetWeaponEnchantTooltip(config.offHandPoisons[1], config.offHandPoisons[2])
	local mainHandAttributes = {type = "item", ["target-slot"] = 16, item1 = config.mainHandPoisons[1], item2 = config.mainHandPoisons[2], threshold = config.thresholdTime}
	local offHandAttributes = {type = "item", ["target-slot"] = 17, item1 = config.offHandPoisons[1], item2 = config.offHandPoisons[2], threshold = config.thresholdTime}

	addon:AddReminder("Main hand poison", addon.WeaponEnchantCallback, mainHandAttributes, nil, nil, mainHandTooltip)
	addon:AddReminder("Off hand poison", addon.WeaponEnchantCallback, offHandAttributes, nil, nil, offHandTooltip)

end
