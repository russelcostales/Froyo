-- Froyo Server
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");

local Struct = {
      [ServerScriptService.Content] = true,
      [ServerScriptService.Modules] = false,
      [ReplicatedStorage.SharedLibrary] = false,
}

require(ReplicatedStorage.Framework.Execute)(Struct);