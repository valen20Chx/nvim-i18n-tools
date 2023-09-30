local mod = {}

local function levenshtein(str1, str2)
  local len1, len2 = #str1, #str2
  local matrix = {}

  for i = 0, len1 do
    matrix[i] = {}
    for j = 0, len2 do
      matrix[i][j] = 0
    end
  end

  for i = 0, len1 do
    matrix[i][0] = i
  end

  for j = 0, len2 do
    matrix[0][j] = j
  end

  for i = 1, len1 do
    for j = 1, len2 do
      local cost = (str1:sub(i, i) ~= str2:sub(j, j) and 1 or 0)
      local deletion = matrix[i - 1][j] + 1
      local insertion = matrix[i][j - 1] + 1
      local substitution = matrix[i - 1][j - 1] + cost
      matrix[i][j] = math.min(deletion, insertion, substitution)
    end
  end

  return matrix[len1][len2]
end

mod.findClosestPath = function(target, pathList)
  local closestPath = pathList[1]
  local closestDistance = levenshtein(target, closestPath)

  for i = 2, #pathList do
    local distance = levenshtein(target, pathList[i])
    if distance < closestDistance then
      closestDistance = distance
      closestPath = pathList[i]
    end
  end

  return closestPath
end

return mod
