local addonName, addon = ...
local config = addon.config.paladin

if config.enabled and addon.playerClass == "PALADIN" then
	local CanBless = function()
		if addon:HasStatsBuff() and addon:HasMasteryBuff() then
			return false
		end

		local kings = select(8, UnitAura("player", "Blessing of Kings"))
		local might = select(8, UnitAura("player", "Blessing of Might"))
		if kings == "player" or might == "player" then
			return false
		end

		return true
	end

	local CanBlessMight = function()
		if CanBless() or addon:HasMasteryBuff() then
			return false
		end

		local kings = select(8, UnitAura("player", "Blessing of Kings"))
		if kings == "player" then
			return false
		end

		return true
	end

	local CanBlessKings = function()
		if CanBless() or addon:HasStatsBuff() then
			return false
		end

		local might = select(8, UnitAura("player", "Blessing of Might"))
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
		addon:AddReminder("Missing Righteous Fury", function() return addon:InPVEInstance() and IsProtection() and not UnitAura("player", "Righteous Fury") end, {type = "spell", spell = "Righteous Fury"})
	end
end
