--Russel Costales 
--@unpartedsoul

local behaviorTree = {}
behaviorTree.__index = behaviorTree
behaviorTree._nodeClasses = {
      decorators = {
            repeater = require(script.Decorators.Repeater),
            untilFail = require(script.Decorators.UntilFail),
            untilSuccess = require(script.Decorators.UntilSuccess),
      },
      actionNode = require(script.ActionNode),
      behaviorEnum = require(script.BehaviorEnum),
      blackboard = require(script.Blackboard),
      condition = require(script.Condition),
      selector = require(script.Selector),
      sequence = require(script.Sequence),
}

function behaviorTree.getNodeClasses()
      return behaviorTree._nodeClasses
end

function behaviorTree.create(...)
      return setmetatable({_selectorRoot = behaviorTree._nodeClasses.selector.create(...)}, behaviorTree)
end

function behaviorTree:run()
      self._stop = false
      task.spawn(function()
            repeat 
                  self._selectorRoot:run() 
            until self._stop
      end)
end

function behaviorTree:stop()
      self._stop = true
end

return behaviorTree