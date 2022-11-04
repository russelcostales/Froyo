-- Partitioner
-- Russel Costales
-- October 21, 2022

local Partitioner = {Partitions = {}};

-- Listens to any changes to values associated with partitions stored. Any tables
-- passed through this function will automatically be pushed into the partitioner.
function Partitioner:Listen(data_access_key, data_content, extends_handler)   
      local proxy = setmetatable({}, {__index = data_content; __newindex = function(_, key_accessed, writing_value)
            -- Utilizes a proxy table to check for any attempts to write to a key so that __newindex fires under the condition that [key] = nil. 
            -- There is an initial handler that will also update the partition and then will pass the task to the extends handler.
            data_content[key_accessed] = writing_value;
            extends_handler(key_accessed, writing_value);
      end;});
      self:Push(data_access_key, proxy);

      return proxy;
end

-- @param data_access_key: the access key the user is attempting to reference the partition by
-- @param data_content: type 'table' attempting to push itself as a value to a key
-- @param overwrites: in the case that there is already an existing partition, confirm the user wants to overwrite the data
function Partitioner:Push(data_access_key, data_content, overwrites)
      if (self.Partitions[data_access_key] and not overwrites) then
            error("Attempt to write to key '%s' but data already exists. Did you try overwriting?");
      end
      self.Partitions[data_access_key] = data_content;
end

function Partitioner:Pull(data_access_key)
      if not (self.Partitions[data_access_key]) then
            warn(("Partitioner attempted to access '%s with nil value"):format(data_access_key));
      end
      return self.Partitions[data_access_key];
end

function Partitioner:Erase(data_access_key)
      if (self.Partitions[data_access_key]) then
            setmetatable(self.Partitions[data_access_key], nil);
            table.clear(self.Partitions[data_access_key]);

            self.Partitions[data_access_key] = nil;
      end
end

return Partitioner;