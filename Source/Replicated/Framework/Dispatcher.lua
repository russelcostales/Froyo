-- Dispatcher
-- Russel Costales
-- October 12, 2022

local Dispatcher = {_registry = {}; _registry_funcs = {}};

local Events
do
      Events = {}
      Events.__index = Events

      function Events.new()
            return setmetatable({
                  _connections = {};
                  _destroyed = false;
                  _firing = false;
                  _bindable = Instance.new("BindableEvent");
            }, Events)
      end

      function Events:Fire(...)
            self._args = {...}
            self._numArgs = select("#", ...)
            self._bindable:Fire()
      end

      function Events:Wait()
            self._bindable.Event:Wait()
            return unpack(self._args, 1, self._numArgs)
      end

      function Events:Connect(func)
            assert(not self._destroyed, "Cannot connect to destroyed event")
            assert(type(func) == "function", "Argument must be function")
            return self._bindable.Event:Connect(function()
                  func(unpack(self._args, 1, self._numArgs))
            end)
      end

      function Events:DisconnectAll()
            self._bindable:Destroy()
            self._bindable = Instance.new("BindableEvent")
      end

      function Events:Destroy()
            if (self._destroyed) then return end
            self._destroyed = true
            self._bindable:Destroy()
      end
end

function Dispatcher:CreateEvent(event_name)
      local event = self._registry[event_name];
      if not event then
            event = Events.new();
            self._registry[event_name] = event;
      end
end

function Dispatcher:CreateFunction(event_name)
      local event = self._registry_funcs[event_name];
      if (event) then
            warn("A bindable function is being overwritten. Canceling.")
            return;
      end
end

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

      event = Instance.new("BindableFunction");

      event.OnInvoke = callback;
      self._registry_funcs[event_name] = event;
end

function Dispatcher:Invoke(event_name, ...)
      if self._registry_funcs[event_name] then
            return self._registry_funcs[event_name]:Invoke(...);
      end
end

return Dispatcher; 