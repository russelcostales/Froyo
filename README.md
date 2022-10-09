![alt text](https://socialify.git.ci/russelcostales/Froyo/image?description=1&font=Inter&language=1&owner=1&pattern=Floating%20Cogs&theme=Dark)

# Froyo Framework
A simple and lightweight framework to organize and accelerate game development workflow. Kept simple to reduce time from
learning a framework and to allow for developers to jump into work with a straight forward client/server structure. The framework
is designed to be the least obstructive in workflow so developers are able to code as normal without having to work around or
heavily work with the framework (which may open up to bad habits and practices). 

## Getting Started
An example shown below shows how module code may begin. All modules who need execution must include a `.Main`, similar to
where programs begin in languages such as C++ and Java. Note that all executables are ran asynchronously.

```lua
local Module = {}

local Players = game:GetService("Players")

local SpawnPoint = workspace.SpawnPoint

function Module:Main()
      local player_util = self.Load("PlayerSpawner")

      Players.PlayerAdded:Connect(function(player)
            player_util:Spawn(SpawnPoint.Position)
      end)
end

return Module
```
## Injected Functions and Modules
`.Load`
Note that the code snippet includes an injected function named `.Load`. All modules with an executor function will be injected
a loader that easily references other modules just by a string. In the case that there are duplicate module names, Froyo will error
at start time. This is also in attempts to mitigate the confusion between multiple script tabs being opened with the same file name,
therefore decreasing development workflow. However, if needed, a future update will include slashes to consider file directories.

## Network (EasyNetwork)
Froyo Framework utilizes EasyNetwork injected in child modules. Visit the [documentation here](https://devforum.roblox.com/t/easynetwork-creates-remote-functionsevents-for-you-so-you-dont-have-to/571258).

## FInteractive (InteractiveEditor)
Modules with the executor function will also be injected with the reference to the Interactive Editor, via `.InteractiveEditor.
This was added onto the framework so that testing becomes easier during run time. Developers may opt into using the editor so that
critical properties or variables may be edited during run time. This may be useful in fine tuning or influencing the behavior
of a particular object dependent on their properties/attributes/variables. 

Below is an example of how the editor may be used.
```lua
local Dog = {}

function Dog:Main()
      function self:Create()
            local dog_component = self.InteractiveEditor:Create("Dog", {
                  Name = "Bailey",
                  Age = 6,
                  Breed = "Labrador Retriever",
            })

            dog_component.Name = "Froyo"
            dog_component.Age = 4

            print(dog_component.Name) --> "Froyo"

            -- Changing the properties of dog component in studio (components are created as configuration folders with
            -- their properties being created as attributes) will also update the dog_component.

            -- For example, if the name was changed in studio to John, then:

            print(dog_component.Name) --> "John"
      end
end

return Dog
```

## Flags
All executable modules are also injected with the Flags module. This may be important if the developer needs globals to multiple
modules to reference to decide behaviors. An example is shown below in how this may be used in projects.
```lua
function Enemies:PathfindAndGetWaypoints()
      -- Pathfinding code
      if (self.Flags.EnvironmentInTesting) then
            -- Create visual points showing where the waypoint nodes are
      end
end
```
