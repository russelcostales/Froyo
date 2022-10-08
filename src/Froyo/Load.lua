-- Froyo Internal Server
-- Russel Costales
-- September 21, 2022

local Functions = {};

local LoadedModules = {};
local Executables = {};
local Initiables = {};

--[[
      Lazy load all modules, process all modules containing a start ('.Main') function. Also can be referenced
      by child modules to reference other child modules. No point of conflict from internal if certain modules
      were loaded by the currently required module due to skipping.
]]
function Functions.Wrap(module)
      --warn(("Wrapping %s"):format(tostring(module)));

      local content = require(module);

      if (typeof(content) == "table") then
            if (typeof(content.Init) == "function" or typeof(content.Main) == "function") then
                  if typeof(content.Network) ~= "nil" then error("ModuleScript '%s' contains key 'Network'"); end
                  if typeof(content.Load) ~= "nil" then error("ModuleScript '%s' contains key 'Load'"); end
                  
                  content.InteractiveEditor = require(script.Parent.InteractiveEditor);
                  content.Flags = require(script.Parent.Flags)
                  content.EventRegistry = require(script.Parent.EventRegistry);
                  content.Wrap = Functions.Wrap;

                  content.Network = Functions.LoadModule("Common/Network")
                  content.Load = Functions.LoadModule
            end
      end

      return content
end

function Functions.LoadModule(module)
      --warn(("Loading module %s"):format(tostring(module)));

      if typeof(module) == "string" and LoadedModules[module] then 
            return LoadedModules[module];
      end

      local content = Functions.Wrap(module)
      
      if (typeof(content) == "table") then
            if (typeof(content.Main) == "function") then
                  table.insert(Executables, content);
            end
            if (typeof(content.Init) == "function") then
                  table.insert(Initiables, content)
            end
      end

      LoadedModules[("%s/%s"):format(module.Parent.Name, module.Name)] = content;
end

function Functions.LoadChildren(children)
      if (typeof(children) ~= "table") then
            error("Attempt to load parameter 'table' with type other than 'table'");
      end
      for _, module in ipairs(children) do
            if module:IsA("ModuleScript") then
                  Functions.LoadModule(module);
            end
      end
end

function Functions.Execute()
      for i = 1, #Initiables do
            Initiables[i]:Init();
            Initiables[i] = nil;
      end
      for i = 1, #Executables do
            task.spawn(function()
                  Executables[i]:Main();
            end);
            Executables[i] = nil;
      end
end

return {
      LoadChildren = Functions.LoadChildren, 
      Execute = Functions.Execute,
};
