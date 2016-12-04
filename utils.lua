#!/usr/bin/lua
-- ---------------------------------------------------------------- -*- Lua -*-
--$LastChangedDate: 2016-03-15 14:46:14 +0100 (Di, 15 Mär 2016) $
--$LastChangedBy: jesus $
--
-- ------------------------------------------------------------------------------

Table = {}

------------------------------------------------------------------------------
function Table.count(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

-- ------------------------------------------------------------------------------
function Table.isArray(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then return false end
  end
  return true
end

----------------------------------------------------------------------------
function Table.getRandomRow(rangeValues)  
  local randomRow = {}
  for _,v in ipairs(rangeValues) do
    if Table.count(v) ~=2 then return nil end
    if v[1] ==nil or v[2] == nil then return nil end
    local vMin = v[1]
    local vMax = v[2]

    --map linearly rand val in [0,1] to range [vmin, vmax]
    table.insert(randomRow, math.random() * (vMax - vMin) + vMin)
  end  

  return randomRow
end

------------------------------------------------------------------------------
function Table.getMinMaxRandomTable(rangeValues, numRows)
  local randomArray = {}

  if numRows < 1 then goto notCorrect end

--check for correct range values  
  for k,v in ipairs(rangeValues) do 
    if Table.isArray(v) == false then
      goto notCorrect
    end
    if Table.count(v) ~= 2 then
      goto notCorrect
    end
    if v[1] > v[2] then 
      goto notCorrect
    end
  end

-- get random rows given value ranges
  for i=1, numRows do    
    randomArray[i] = Table.getRandomRow(rangeValues, 1)
  end

  do return randomArray end

  ::notCorrect::
  print('Error: bad range of values, ex. rangeValues={{min1, max1}, {min2, max2},.., {minN, maxN},}')
  return nil    
end

-- ------------------------------------------------------------------------------
function Table.getKeysSortedByValue1D(tbl, sortFunction)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end

  table.sort(keys, function(a, b)
      return sortFunction(tbl[a], tbl[b])
    end)

  return keys
end

-- ...........................................................................
function Table.reduce(list, fn) 
  if type(list) ~= 'table' then return end

  local acc 
  
  --for k, v in ipairs(list) do
  local first = true
  for _, v in pairs(list) do    
    if first then
      acc = v
      first = false
    else
      acc = fn(acc, v)
    end 
  end 
  return acc 
end
