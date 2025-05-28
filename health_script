local scriptName = "🎯 Health Freeze Tool"
local searchType = gg.TYPE_DWORD
local healthTargetValues = {375648,143134,149290} -- Add multiple values here

-- 📌 Store frozen values globally for later unfreeze
local frozenResults = {}

function darkQueenFreezeScript()
    gg.clearResults()
    local totalFiltered = {}

    for _, targetValue in ipairs(healthTargetValues) do
        gg.searchNumber(targetValue, searchType)
        local results = gg.getResults(1000)

        for i, v in ipairs(results) do
            local addrPlus4 = v.address + 4
            local check = gg.getValues({{address = addrPlus4, flags = searchType}})
            if check[1].value == targetValue then
                v.freeze = true
                table.insert(totalFiltered, v)
                print(string.format("✅ 0x%X = %d (Also +4 = %d)", v.address, v.value, check[1].value))
            end
        end

        gg.clearResults()
    end

    frozenResults = totalFiltered
    gg.setValues(frozenResults)
    gg.addListItems(frozenResults)
    gg.toast("✅ Frozen " .. #frozenResults .. " values")
end

function unfreezeAll()
    if #frozenResults == 0 then
        gg.toast("❌ Nothing to unfreeze.")
        return
    end

    for _, v in ipairs(frozenResults) do
        v.freeze = false
    end
    gg.setValues(frozenResults)
    gg.removeListItems(frozenResults)
    gg.toast("❄️ Unfrozen " .. #frozenResults .. " values")
    frozenResults = {}
end

function mainMenu()
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            local choice = gg.choice({
                "🎮 Run DarkQueen  (Search + Freeze)",
                "❄️ Unfreeze All",
                "🔄 Exit"
            }, nil, scriptName)

            if choice == 1 then
                darkQueenFreezeScript()
            elseif choice == 2 then
                unfreezeAll()
            elseif choice == 3 then
                gg.toast("👋 Exiting " .. scriptName)
                os.exit()
            end
        end
    end
end

-- 🚀 Start the menu loop
mainMenu()
