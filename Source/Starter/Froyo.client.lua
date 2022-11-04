-- Froyo Starter
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Interface = script.Parent.Parent:WaitForChild("Interface");
local Client = script.Parent.Parent:WaitForChild("Client");

local Struct = {
      Interface:GetChildren(),
      Client.Modules:GetChildren(),
      Client.Content:GetChildren(),
      Client.World:GetChildren(),
      ReplicatedStorage.SharedLibrary:GetChildren(),
}

require(ReplicatedStorage.Framework.Execute)(Struct);