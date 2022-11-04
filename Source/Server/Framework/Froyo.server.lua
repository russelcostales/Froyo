-- Froyo Server
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");

local Struct = {
      ServerScriptService.Content:GetChildren(),
      ServerScriptService.Modules:GetChildren(),
      ServerScriptService.World:GetChildren(),
      ReplicatedStorage.SharedLibrary:GetChildren(),
}

require(ReplicatedStorage.Framework.Execute)(Struct);