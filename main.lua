---<< FUNCTIONS >>---
local function runScriptForSpecificID(gameName, placeIdsTable, func)
    placeIdsTable = placeIdsTable or {}
    func = func or function() end
  
    for _, placeId in ipairs(placeIdsTable) do
        if placeId == 0 then
            func()
            return
        end

        if game.PlaceId == placeId then
            func()
            return
        end
    end
end


---<< MAIN >>---
