-- Froyo Internal Server
-- Russel Costales
-- September 21, 2022

local Loader = require(game:GetService("ReplicatedStorage").Froyo.Load);

Loader.LoadChildren(game:GetService("ReplicatedStorage").Common:GetChildren());
Loader.LoadChildren(script:GetChildren());
Loader.LoadChildren(script.Interactives:GetChildren());

Loader.Execute();