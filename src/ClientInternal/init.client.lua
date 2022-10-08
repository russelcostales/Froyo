-- Froyo Internal Server
-- Russel Costales
-- September 21, 2022

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Loader = require(game:GetService("ReplicatedStorage").Froyo.Load);

Loader.LoadChildren(ReplicatedStorage.Common:GetChildren());
Loader.LoadChildren(ReplicatedStorage.Froyo.Client.Interface:GetChildren());
Loader.LoadChildren(ReplicatedStorage.Froyo.Client.Interactives:GetChildren());
Loader.LoadChildren(ReplicatedStorage.Froyo.Client:GetChildren());

Loader.Execute();