local sequence = {}
sequence._type = "sequence"
sequence.__index = sequence

local BehaviorEnum = require(script.Parent.BehaviorEnum)

function sequence.create(...)
      local orderedNodes = {...}
      for _, v in pairs(orderedNodes) do
            if typeof(v) ~= "table" or typeof(v) == "table" and typeof(v.run) ~= "function" then
                  error(("Sequence error, passed argument '%s' is not a valid sub class"):format(tostring(v)))
            end
      end
      return setmetatable({_sequence = orderedNodes}, sequence)
end

function sequence:run()
      local status
      for _, node in ipairs(self._sequence) do
            status = node:run()
            if status == BehaviorEnum.status.failure then
                  break
            end
      end
      return status or BehaviorEnum.status.failure
end

return sequence