-- Froyo Starter
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Struct = {
      script.Parent.Parent:WaitForChild("Modules"):GetChildren(),
      script.Parent.Parent:WaitForChild("Content"):GetChildren(),
      ReplicatedStorage:WaitForChild("SharedLibrary"):GetChildren(),
}

require(ReplicatedStorage.Framework.Execute)(Struct)