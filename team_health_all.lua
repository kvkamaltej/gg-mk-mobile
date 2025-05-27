-- 🎯 Define your list of target values
local targetValues = {375648,134969, 149290}
local searchType = gg.TYPE_DWORD -- Use TYPE_FLOAT, etc. if needed

-- Clear previous scan results
gg.clearResults()

-- Store all valid filtered addresses
local totalFiltered = {}

-- Loop over each target value
for _, targetValue in ipairs(targetValues) do
    gg.searchNumber(targetValue, searchType)
    local results = gg.getResults(1000)
    
    for i, v in ipairs(results) do
        local addrPlus4 = v.address + 4
        local check = gg.getValues({{address = addrPlus4, flags = searchType}})
        if check[1].value == targetValue then
            table.insert(totalFiltered, v)
        end
    end

    gg.clearResults()
end

-- Load and show filtered results
gg.loadResults(totalFiltered)
gg.toast("✅ Filtered: " .. #totalFiltered .. " total matching results")
gg.addListItems(totalFiltered)
gg.setValues(totalFiltered)
for _, v in ipairs(totalFiltered) do v.freeze = true end
gg.addListItems(totalFiltered)
