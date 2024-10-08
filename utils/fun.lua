local M = {}

M.tbl_merge = function(t1, ...)
  local tables = { ... }

  for _, t2 in ipairs(tables) do
    for k, v in pairs(t2) do
      if type(v) == 'table' then
        if type(t1[k] or false) == 'table' then
          M.tbl_merge(t1[k] or {}, t2[k] or {})
        else
          t1[k] = v
        end
      else
        t1[k] = v
      end
    end
  end

  return t1
end

return M
