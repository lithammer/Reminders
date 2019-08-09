local addonName, addon = ...
local config = addon.config.paladin

if config.enabled and addon.playerClass == "PALADIN" then
	local CanBless = function()
		if addon:HasStatsBuff() and addon:HasMasteryBuff() then
			return false
		end

		local kings = select(8, AuraUtil.FindAuraByName("Blessing of Kings", "player"))
		local might = select(8, AuraUtil.FindAuraByName("Blessing of Might", "player"))
		if kings == "player" or might == "player" then
			return false
		end

		return true
	end

	local CanBlessMight = function()
		if CanBless() or addon:HasMasteryBuff() then
			return false
		end

		local kings = select(8, AuraUtil.FindAuraByName("Blessing of Kings", "player"))
		if kings == "player" then
			return false
		end

		return true
	end

	local CanBlessKings = function()
		if CanBless() or addon:HasStatsBuff() then
			return false
		end

		local might = select(8, AuraUtil.FindAuraByName("Blessing of Might", "player"))
		if might == "player" then
			return false
		end

		return true
	end

	addon:AddReminder("Missing blessing", function() return CanBless() end, {type = "spell", unit = "player", spell1 = config.blessings[1], spell2 = config.blessings[2]})
	addon:AddReminder("Missing Blessing of Might", function() return CanBlessMight() end, {type = "spell", unit = "player", spell = "Blessing of Might"})
	addon:AddReminder("Missing Blessing of Kings", function() return CanBlessKings() end, {type = "spell", unit = "player", spell = "Blessing of Kings"})

	local IsProtection = function()
		return GetSpecialization() == 2
	end

	if config.righteousFury then
		addon:AddReminder("Missing Righteous Fury", function() return addon:InPVEInstance() and IsProtection() and not AuraUtil.FindAuraByName("Righteous Fury", "player") end, {type = "spell", spell = "Righteous Fury"})
	end
end
