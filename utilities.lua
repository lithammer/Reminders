local addonName, addon = ...

function addon:IsInPartyWith(class)
	local numMembers = GetNumSubgroupMembers()

	if numMembers then
		for i = 1, numMembers do
			local unit = "party" .. i

			if not UnitIsPlayer("unit") and select(2, UnitClass(unit)) == class then
				return true
			end
		end
	end

	return false
end

function addon:HasAnyAura(names, filter)
	if not filter then
		filter = "HELPFUL"
	end

	for _, name in pairs(names) do
		if AuraUtil.FindAuraByName(name, "player", filter) then
			return true
		end
	end

	return false
end

function addon:InPVEInstance()
	isInstance, instanceType = IsInInstance()

	if isInstance then
		return instanceType == "party" or instanceType == "raid"
	end

	return false
end

function addon:HasTalent(tabIndex, talentIndex)
	return select(5, GetTalentInfo(tabIndex, talentIndex)) > 0
end

function addon:MinPlayerLevel(lvl)
	return UnitLevel("player") >= lvl
end

local fishingPole = select(17, GetAuctionItemSubClasses(1))
local shield = select(6, GetAuctionItemSubClasses(1))

function addon:HasEnchantableWeapon(slot)
	local link = GetInventoryItemLink("player", slot)

	if link then
		local quality = select(3, GetItemInfo(link))
		local subClass, _, equipSlot = select(7, GetItemInfo(link))
		local localizedSlot = _G[equipSlot]

		return quality and quality > 1 and subClass ~= shield and subClass ~= fishingPole and (localizedSlot == INVTYPE_WEAPON or localizedSlot == INVTYPE_THROWN or localizedSlot == INVTYPE_2HWEAPON or localizedSlot == INVTYPE_WEAPONMAINHAND or localizedSlot == INVTYPE_WEAPONOFFHAND)
	end
end

function addon:GetWeaponEnchantTooltip(primary, secondary)
	local tooltip

	if primary == secondary then
		tooltip = "Click to apply " .. primary
	else
		tooltip = "Left-click to apply " .. primary .. "\nRight-click to apply " .. secondary
	end

	return tooltip
end

function addon:WeaponEnchantCallback()
	local slot = self:GetAttribute("target-slot") or self:GetAttribute("slot")
	local hasEnchant, expiration = select(((slot - 16) * 3) + 1, GetWeaponEnchantInfo())
	local validWeapon = addon:HasEnchantableWeapon(slot)

	if hasEnchant then
		local timeLeft = expiration / 1000
		local threshold = self:GetAttribute("threshold") * 60

		if timeLeft < threshold then
			self.title = self.name .." expiring in " .. SecondsToTime(timeLeft, nil, true):lower()
			self.setColor(1, 1, 1)

			return validWeapon
		end
	elseif validWeapon then
		self.title = self.name .. " missing"
		self.setColor(1, 0.1, 0.1)

		return true
	end
end

local infinity = math.huge

function addon:ColorGradient(value, ...)
	if value ~= value or value == infinity then
		value = 0
	end

	if value >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)

		return r, g, b
	elseif value <= 0 then
		local r, g, b = ...

		return r, g, b
	end

	local segmentCount = select('#', ...) / 3
	local segment, relativePercent = math.modf(value * (segmentCount - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)

	return r1 + (r2 - r1) * relativePercent, g1 + (g2 - g1) * relativePercent, b1 + (b2 - b1) * relativePercent
end

function addon:ConditionColorGradient(value)
	return addon:ColorGradient(value, 1, 0, 0, 1, 1, 0, 0, 1, 0)
end

function addon:HasStatsBuff()
	return self:HasAnyAura({
		"Mark of the Wild",
		"Legacy of the Emperor",
		"Legacy of the White Tiger",
		"Blessing of Kings",
		"Embrace of the Shale Spider"
	})
end

function addon:HasStaminaBuff()
	return self:HasAnyAura({
		"Power Word: Fortitude",
		"Blood Pact",
		"Commanding Shout",
		"Qiraji Fortitude"
	})
end

function addon:HasAttackPowerBuff()
	return self:HasAnyAura({
		"Horn of Winter",
		"Trueshot Aura",
		"Battle Shout"
	})
end

function addon:HasSpellPowerBuff()
	return self:HasAnyAura({
		"Dark Intent",
		"Arcane Brilliance",
		"Dalaran Brilliance",
		"Serpent's Cunning",
		"Still Water"
	})
end

function addon:HasHasteBuff()
	return self:HasAnyAura({
		"Cackling Howl",
		"Energizing Spores",
		"Mind Quickening",
		"Swiftblade's Cunning",
		"Unholy Aura",
		"Grace of Air"
	})
end

function addon:HasCriticalStrikeBuff()
	return self:HasAnyAura({
		"Legacy of the White Tiger",
		"Leader of the Pack",
		"Arcane Brilliance",
		"Dalaran Brilliance",
		"Bellowing Roar",
		"Furious Howl",
		"Terrifying Roar",
		"Fearless Roar",
		"Still Water"
	})
end

function addon:HasMasteryBuff()
	return self:HasAnyAura({
		"Blessing of Might",
		"Grace of Air",
		"Roar of Courage",
		"Spirit Beast Blessing"
	})
end

function addon:HasMultistrikeBuff()
	return self:HasAnyAura({
		"Mind Quickening",
		"Swiftblade's Cunning",
	})
end
