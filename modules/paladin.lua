if select(2, UnitClass("player")) == "PALADIN" then
	local config = evl_Reminders.config.paladin
	
	evl_Reminders:AddReminder("No active aura", function() return not evl_Reminders:PlayerHasAnyAura(config.auras, "PLAYER|HELPFUL") end, "Spell_Holy_Devotionaura", {type = "spell", unit = "player", spell1 = config.auras[1], spell2 = config.auras[2]})
	evl_Reminders:AddReminder("No active seal", function() return not evl_Reminders:PlayerHasAnyAura(config.seals, "PLAYER|HELPFUL") end, "Spell_Holy_Devotionaura", {type = "spell", unit = "player", spell1 = config.seals[1], spell2 = config.seals[2]})
	evl_Reminders:AddReminder("Missing blessing", function() return not evl_Reminders:PlayerHasAnyAura(config.blessings) end, "Spell_Holy_Devotionaura", {type = "spell", unit = "player", spell1 = config.blessings[1], spell2 = config.blessings[2]})
end