-- Garbage Collector
-- Russel Costales
-- September 30, 2022

-- Scheduled deletions of instances over some interval

local GARBAGE_COLLECT_INTERVAL = 3

local GarbageCollector = {_instances = {}};

local function CollectGarbage()
      GarbageCollector._collecting_scheduled = nil;

      if (#GarbageCollector._instances == 0) then return; end
      for garbage_index = #GarbageCollector._instances, -1, 1 do
            GarbageCollector._instances[garbage_index]:Destroy();
            
            table.remove(GarbageCollector._instances, garbage_index); -- safe cleaning everyone!
      end
end

function GarbageCollector:GiveInstance(instance)
      if typeof(instance) ~= "Instance" then error("Garbage collector, bad instance. %s"):format(debug.traceback()); end

      table.insert(self._instances, instance);

      if not (GarbageCollector._collecting_scheduled) then
            GarbageCollector._collecting_scheduled = task.delay(GARBAGE_COLLECT_INTERVAL, CollectGarbage)
      end
end

return GarbageCollector;