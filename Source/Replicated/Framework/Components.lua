-- Interactive Editor
-- Russel Costales
-- September 21, 2022

--[[
      Interactive editor allows for real time updating of values so that games do not have to be restarted
      when a property is changed. This eliminates having to repeatedly play and stop to test a value critical
      to a module's process.
]]

local PhysicalStorage = Instance.new("Folder", game:GetService("ReplicatedStorage"));
PhysicalStorage.Name = "InteractiveEditor";

local Components = {};

-- Creates a new component and adds it to the editor's register. Anything created by the Interactive Editor 
-- is under the class 'Component', which then inherits 'Properties'. All components will then be
-- created as Instance class 'Configuration' where attributes will be used. 

      --@param inherits_properties: [property_name] = default_value
function Components:Create(component_name, inherits_properties)
      local component = Instance.new("Configuration", PhysicalStorage);
      component.Name = component_name;

      -- Keep track of updated values of each attributes. Three tables are used here for
      -- two way communication/updating (studio or code). This becomes easier to get property
      -- values without having to call :GetAttribute(). 
      local component_live_sync = {};
      local component_sync_proxy = {};
      local proxy_meta = {};

      for property_name, default_value in pairs(inherits_properties) do
            if (typeof(property_name) ~= "string") then
                  -- Property name must be of type 'string'
                  error(("Attempt to create component but property_name '%s' is not type 'string'"):format(tostring(component_name)));
            else
                  component:SetAttribute(property_name, default_value);
                  component_live_sync[property_name] = default_value;
            end
      end
 
      proxy_meta.__index = component_sync_proxy;
      proxy_meta.__newindex = function(t, i, v)
            if t[i] ~= v then
                  component_sync_proxy[i] = v;
                  component:SetAttribute(i, v);
            end
      end

      setmetatable(component_live_sync, proxy_meta);

      component.AttributeChanged:Connect(function(component_name)
            component_live_sync[component_name] = component:GetAttribute(component_name);
      end)

      return component_live_sync;
end

return Components;