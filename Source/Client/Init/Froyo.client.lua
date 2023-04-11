-- Froyo Starter
-- Russel Costales
-- October 11, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Struct = {
      [script.Parent.Parent:WaitForChild("Content")] = true,
      [script.Parent.Parent:WaitForChild("Modules")] = false,
      [ReplicatedStorage:WaitForChild("SharedLibrary")] = false,
}

require(ReplicatedStorage.Framework.Execute)(Struct)