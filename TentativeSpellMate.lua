TentativeSpellMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> SpellMate", "AceConsole-3.0", "AceEvent-3.0")

function TentativeSpellMate:SaveSpells(name)
    TentativeSpellMate:Print("Saving Spell Data")
    local SpellList = {}

    SpellList[name] = {}
    SpellList[name]["spells"] = {}

    local i = 1
    while true do
        local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL)
        if not spellName then do break end end

        SpellList[name]["spells"] = {
            spellName = spellName,
            spellRank = spellSubName
        }

        i = i + 1
    end

    SpellLocker = SpellList
end

TentativeSpellMate:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    name = GetUnitName("player", true)
    SpellLocker = {}
    TentativeSpellMate:SaveSpells(name)
end)
