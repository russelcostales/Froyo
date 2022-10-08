local untilFail = {}
untilFail._type = "untilFailDecorator"
untilFail.__index = untilFail

local BehaviorEnum = require(script.Parent.Parent.BehaviorEnum)

function untilFail.create(callNode)
      return setmetatable({_callNode = callNode}, untilFail)
end

function untilFail:run()
      local status
      repeat
            status = self._callNode:run()
      until status == BehaviorEnum.status.failure
      return not status
end

return untilFail