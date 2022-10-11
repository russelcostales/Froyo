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

local Initiables  = {};
local Executables = {};
local Files       = {};

local function FileStoreDescendantModules(struct)
      if (typeof(struct) ~= "table") then error("Invalid struct, not type 'table'") end;
      
      for _, descendant in ipairs(struct) do
            if (typeof(descendant) ~= "Instance") then continue; end

            local identifier = descendant.Parent:IsA("ModuleScript") and "@" or "$";
            local path_str = ("%s%s.%s"):format(identifier, descendant.Parent.Name, descendant.Name);

            Files[path_str] = descendant;
            
            local descendants_of_descendant = descendant:GetChildren();
            if not (descendants_of_descendant > 0) then continue; end

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

      FileStoreDescendantModules(struct);
      print(Files)

      for index = 1, #Initiables, 1 do

            Initiables[index]:Init();
            Initiables[index] = nil;
      end

      for index = 1, #Executables, 1 do
            task.spawn(function()
                  Executables[index]:Main();
            end);

            Executables[index] = nil;
      end
end