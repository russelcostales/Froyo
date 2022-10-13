-- Froyo Server 2
-- Russel Costales
-- October 11, 2022

local IS_SERVER = game:GetService("RunService"):IsClient();

local Locked = false;

-- @Initiables @Executables Containers for separating modules with an initializer, and an executor function.
-- initializers will run first synchronously followed by execution, given that the 'main'
-- identifier function is found. 
      -- @Dependents All modules whose parent is of type 'ModuleScript' will be stored into the files table,
      -- but any found initializer function or executable function will not be run and will be at the discretion
      -- of the parent module. 

-- @Files Storage of all files found as a descendant of struct folders. This is stored as a dictionary,
-- where @ signifies the parent.

local Paths       = {};
local Executables = {};
local Files       = {};

local Dispatcher = require(script.Parent.Dispatcher);
local Components = require(script.Parent.Components);

local function __import(string_path)
      if not (Files[string_path]) then return; end

      if (typeof(Files[string_path]) ~= "table") then
            Files[string_path] = require(Files[string_path]);
      end

      return Files[string_path];
end

local function __include(string_identifier)
      return (string_identifier == "%Dispatcher") and Dispatcher or (string_identifier == "%Components") and Components;
end

local function __inject(module_table)
      module_table.import = __import;
      module_table.include = __include;
end

local function FileStoreDescendantModules(struct)
      if (typeof(struct) ~= "table") then error("Invalid struct, not type 'table'") end;
      
      for _, descendant in ipairs(struct) do
            if (typeof(descendant) ~= "Instance") then continue; end

            local identifier = descendant.Parent:IsA("ModuleScript") and "@" or "$";
            local path_str = ("%s%s.%s"):format(identifier, descendant.Parent.Name, descendant.Name);

            Files[path_str] = descendant;
            Paths[#Paths+1] = path_str;
            
            local descendants_of_descendant = descendant:GetChildren();
            if not (#descendants_of_descendant > 0) then continue; end

            FileStoreDescendantModules(descendants_of_descendant);
      end
end

return function(struct)
      if (Locked) then
            error(("Illegal multi execution found in: %s"):format(IS_SERVER and "Server" or "Client"));
      end

      -- Prevent multi execution. Any attempt to do so will error at start runtime so that it can be
      -- caught early. The executor should not be called to load directories one at a time, instead pass everything
      -- needed once.
      Locked = true;

      _G.import = __import
      _G.include = __include

      for _, folder in ipairs(struct) do
            FileStoreDescendantModules(folder);
      end

      for _, path_string in ipairs(Paths) do
            Paths[path_string] = nil;

            local parent_identifier = path_string:sub(1, 1);
            if (parent_identifier ~= "$") then continue; end

            local module_content = __import(path_string)
      
            if (typeof(module_content) ~= "table") then continue; end

            local contains_init = typeof(module_content.Init) == "function";
            local contains_exec = typeof(module_content.Main) == "function";

            module_content.f_inject = __inject;

            if (contains_init) then
                  module_content:Init();
            end
            
            if not (contains_exec) then continue; end
            Executables[#Executables+1] = module_content;
      end

      for index = 1, #Executables, 1 do
            task.spawn(function()
                  Executables[index]:Main();
            end);

            Executables[index] = nil;
      end

      table.clear(_G);
end