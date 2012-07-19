Rule-based automated reminders for commonly forgotten tasks.

![](http://i37.tinypic.com/2lsziq9.jpg)

## Configuration

Copy `config.lua.sample` to `config.lua` and modify as required.

## Usage

Alt + right-click a reminder icon to bring up context menu

## Modules

**Druid**

* Missing Mark of the Wild

**Mage**

* Armor missing (Molten Armor or Mage Armor)
* Missing Arcane Brilliance

**Paladin**

* Missing blessing
* Missing Righteous Fury

**Priest**

* Missing Power Word: Fortitude
* Missing Inner Fire/Will

**Rogue**

* Main/Off-hand poison missing
* Main/Off-hand poison expiring soon

**Shaman**

* Missing shield (Water Shield, Lightning Shield)
* Main/Off-hand weapon enchant missing
* Main/Off-hand weapon enchant expiring soon

**Warlock**

* Missing Dark Intent
* Missing Soul Link

**Consumables**

* Food buff expiration warning
* Flask expiration warning

**General**

* Less than 3 bag-slots available
* No bag-slots available

## Customization

You can add your own custom reminders with the following syntax:

```lua
addon:AddReminder(name, event, callback, icon, attributes, tooltip, color)
```

See existing modules for in-depth examples.
