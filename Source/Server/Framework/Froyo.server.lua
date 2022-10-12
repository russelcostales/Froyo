-- Froyo Server
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");

local Struct = {
      ServerScriptService.Packages:GetChildren(),
      ServerScriptService.Modules:GetChildren(),
      ServerScriptService.World:GetChildren(),
      ReplicatedStorage.Libraries:GetChildren(),
}

require(ReplicatedStorage.Framework.Execute)(Struct);