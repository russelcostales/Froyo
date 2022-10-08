-- Froyo Internal Server
-- Russel Costales
-- September 21, 2022

local LoadChildren = require(game:GetService("ReplicatedStorage").Froyo.Load);

LoadChildren(game:GetService("ReplicatedStorage").Common:GetChildren());
LoadChildren(script:GetChildren());