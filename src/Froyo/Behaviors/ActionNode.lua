local actionNode = {}
actionNode._type = "ActionNode"
actionNode.__index = actionNode

local BehaviorEnum = require(script.Parent.BehaviorEnum)

function actionNode.create(callback)
      return setmetatable({_callback = callback}, actionNode)
end

function actionNode:run()
      return self._callback() or BehaviorEnum.status.failure
end

return actionNode