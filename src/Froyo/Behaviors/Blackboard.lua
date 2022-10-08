local blackboard = {}
blackboard._type = "Blackboard"
blackboard.__index = blackboard

function blackboard.create()
      return setmetatable({_data = {}}, blackboard)
end

function blackboard:set(key, value)
      if typeof(key) ~= "string" then
            error("Attempt to set key to blackboard, key is not type 'string'")
      end
      if self._data[key] then
            if value ~= nil and typeof(self._data[key]) ~= typeof(value) then
                  error("Attempt to set key '%s' with value typeof '%s' to different typeof '%s'"):format(key, typeof(self._data[key]), typeof(value))
            else
                  self._data[key] = value
            end
      else
            self._data[key] = value
      end
end

function blackboard:get(key)
      if typeof(key) ~= "string" then
            error("Attempt to retrieve value from key but key is not typeof 'string'")
      end
      return self._data[key]
end

return blackboard