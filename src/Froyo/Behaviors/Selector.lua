local selector = {}
selector._type = "selector"
selector.__index = selector

local BehaviorEnum = require(script.Parent.BehaviorEnum)

function selector.create(...)
      local orderedNodes = {...}
      for _, v in pairs(orderedNodes) do
            if typeof(v) ~= "table" or typeof(v) == "table" and typeof(v.run) ~= "function" then
                  error(("Selector error, passed argument '%s' is not a valid sub class"):format(tostring(v)))
            end
      end
      return setmetatable({_sequence = orderedNodes}, selector)
end

function selector:run()
      local status
      for _, node in ipairs(self._sequence) do
            status = node:run()
            if status == BehaviorEnum.status.success then
                  break
            end
      end
      return status or BehaviorEnum.status.failure
end

return selector