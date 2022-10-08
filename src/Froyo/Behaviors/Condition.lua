local conditionNode = {}
conditionNode._type = "ConditionNode"
conditionNode.__index = conditionNode

local BehaviorEnum = require(script.Parent.BehaviorEnum)

function conditionNode.create(conditionCheckFunction, ifTrueNode, ifFalseNode)
      return setmetatable({
            _conditionCheckFunction = conditionCheckFunction, 
            _ifTrueNode = ifTrueNode, 
            _ifFalseNode = ifFalseNode,
      }, conditionNode)
end

function conditionNode:run()
      if self._conditionCheckFunction() then
            return self._ifTrueNode:run() or BehaviorEnum.status.failure
      else
            return self._ifFalseNode:run() or BehaviorEnum.status.failure
      end
end

return conditionNode