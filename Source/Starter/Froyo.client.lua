-- Froyo Starter
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Struct = {
      ReplicatedStorage.Client.Interface:GetChildren(),
      ReplicatedStorage.Client.Modules:GetChildren(),
      ReplicatedStorage.Client.World:GetChildren(),
      ReplicatedStorage.Libraries:GetChildren(),
}

require(ReplicatedStorage.Framework.Execute)(Struct);