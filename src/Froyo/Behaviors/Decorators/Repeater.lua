local repeater = {}
repeater._type = "repeaterDecorator"
repeater.__index = repeater

local BehaviorEnum = require(script.Parent.Parent.BehaviorEnum)

function repeater.create(callNode, repeatUntil)
      return setmetatable({
            _callNode = callNode, 
            _repeatUntil = repeatUntil,
      }, repeater)
end

function repeater:run()
      for i = 1, self._repeatUntil, 1 do
            self._callNode:run()
      end
      return BehaviorEnum.status.success
end

return repeater