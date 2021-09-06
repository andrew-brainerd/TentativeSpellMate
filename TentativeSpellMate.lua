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
        if not spellName then do break end end

        SpellList[name]["spells"][i] = {
            spellName = spellName,
            spellRank = spellRank
        }

        i = i + 1
    end

    SpellLocker = SpellList
end

function TentativeSpellMate:ShouldUpdateSpells()
    return lastUpdateTime == nil or time() - lastUpdateTime > 1000
end

TentativeSpellMate:RegisterEvent("GUILD_ROSTER_UPDATE", function()
    local guildName = GetGuildInfo("player")

    if (guildName == "Tentative" and TentativeSpellMate:ShouldUpdateSpells()) then
        TentativeSpellMate:SaveSpells(name)
    end
end)
