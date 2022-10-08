local untilSuccess = {}
untilSuccess._type = "untilSuccessDecorator"
untilSuccess.__index = untilSuccess

local BehaviorEnum = require(script.Parent.Parent.BehaviorEnum)

function untilSuccess.create(callNode)
      return setmetatable({_callNode = callNode}, untilSuccess)
end

function untilSuccess:run()
      local status
      repeat
            status = self._callNode:run()
      until status == BehaviorEnum.status.success
      return status
end

return untilSuccess