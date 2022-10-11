-- Event Registry
-- Russel Costales
-- September 23, 2022

--[[
      Event registry created for Sleitnick's event class. This way, other scripts can get/retrieve an event
      without issue. Also mitigates the issue where an event might not exist yet.
]]

local Dispatcher = {_registry = {}; _registry_funcs = {}};

local Events = require(game:GetService("ReplicatedStorage").Common.Event)

function Dispatcher:Connect(event_name, callback)
      local event = self._registry[event_name];
      if not event then
            event = Events.new();
            self._registry[event_name] = event;
      end
      return event:Connect(callback);
end

function Dispatcher:Fire(event_name, ...)
      if not self._registry[event_name] then
            return;
      end
      self._registry[event_name]:Fire(...);
end

function Dispatcher:Bind(event_name, callback)
      local event = self._registry_funcs[event_name];
      if (event) then
            warn("A bindable function is being overwritten. Canceling.")
            return;
      end
      event = Instance.new("BindableFunction")
      event.OnInvoke = callback
      self._registry_funcs[event_name] = event;
end

function Dispatcher:FireFunc(event_name, ...)
      if self._registry_funcs[event_name] then
            return self._registry_funcs[event_name]:Invoke(...);
      end
end

return Dispatcher; 