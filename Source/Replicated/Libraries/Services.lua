-- Services
-- Russel Costales
-- September 22, 2022

--[[
      Quick way to reference the services we need so that we don't have to keep calling
      :GetService repeatedly. 
]]

local Services = {};
for _, service in ipairs(game:GetChildren()) do
      local success, error_message = pcall(function()
            Services[(service.Name):gsub(" ", "")] = game:GetService((service.Name):gsub(" ", ""));
            --service.Name = tostring(math.random()) -- Issue where renaming on the server makes it difficult for clients to retrieve the services
      end);
      --[[
      if success then
            print(service)
      end
      ]]
end
Services.PathfindingService = game:GetService("PathfindingService");
Services.UserInputService = game:GetService("UserInputService");

return Services;