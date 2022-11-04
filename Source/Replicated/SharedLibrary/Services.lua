-- Services
-- Russel Costales
-- October 20, 2022

local Loaded_Services = {};
local Services_Meta   = {};

local function GetService(service_name)
      return game:GetService(service_name);
end

function Services_Meta.__index(_, service_name)
      local _, service_received = pcall(GetService, service_name)
      
      if (service_received) then 
            Loaded_Services[service_name] = service_received;
            return Loaded_Services[service_name];
      end
end

return setmetatable(Loaded_Services, Services_Meta);