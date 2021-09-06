TentativeSpellMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> SpellMate", "AceConsole-3.0", "AceEvent-3.0")

lastUpdateTime = nil

function TentativeSpellMate:SaveSpells()
    TentativeSpellMate:Print("Saving Spell Data")

    local name = GetUnitName("player", true)
    local SpellList = {}

    SpellList[name] = {}
    SpellList[name]["spells"] = {}

    local i = 1
    while true do
        local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL)
        TentativeSpellMate:Print("Spell Name: " .. spellName)
        TentativeSpellMate:Print("Spell Name 2: " .. spellSubName)
        if not spellName then do break end end

        SpellList[name]["spells"] = {
            spellName = spellName,
            spellRank = spellSubName
        }

        i = i + 1
    end

    SpellLocker = SpellList
end

function TentativeSpellMate:ShouldUpdateGuild()
    return lastUpdateTime == nil or time() - lastUpdateTime > 10000
end


TentativeSpellMate:RegisterEvent("GUILD_ROSTER_UPDATE", function()
    SpellLocker = {}

    local guildName = GetGuildInfo("player")

    if (guildName == "Tentative" and TentativeSpellMate:ShouldUpdateGuild()) then
        TentativeSpellMate:SaveSpells(name)
    end
end)
