![alt text](https://socialify.git.ci/russelcostales/Froyo/image?description=1&font=Inter&language=1&owner=1&pattern=Floating%20Cogs&theme=Dark)

## About
A framework designed for developers to immediately begin programming games without the worries of organizing or
setting up an architecture that is scalable, easy to work with and learn.

## Basic Usage
Modules containing the ``Main`` and ``Init`` identifiers will be recognized as an initiable and/or executable module. It is **strongly recommended** to register any bindables
or network events in the Init function to ensure that all events exist when firing. It is not required to have both, only use when needed.
```lua
local Module = {};

function Module:Main()
end

function Module:Init()
end

return Module;
```

## Importing and Including
The import and include function are vital tools that make working with a single script architecture much more easy. While not required to be used, they are
stored in the global environment during the initial internal framework setup. 
**Important:** By default, Froyo removes the import and include functions from the global environment. This can be modified, but it is recommended to require modules once
they are required. 

### Import
Imports can be used to require other modules. They only require a string for reference, and the pathway only requires the module's immediate parent. This reduces
the issues of module name conflicts and can also be used for dependency modules. 
**Note:** Modules with parent "Folder" denotes ``"$"`` and dependency modules denotes ``"%"`` as pointers. This is done so it is easy to distinguish component modules.
```lua
local import = _G.import;

local Package_1 = import "$Packages.Package_1"; -- Equivalent to require(... .Packages.Package_1);
local Component_of_curr_file = import "@File_Name.Component"; -- Equivalent to require(script.Component);
local Component_of_component = import "@Component.Component"; -- Equivalent to require(script.Component.Component);
```

### Include
While optional, Froyo has two modules that can be used to aid in game development. The ``Dispatcher`` and the ``Components`` modules can be referenced by using the ``_G.include`` function.
See the information below about the modules provided.

The **dispatcher** is a registry for both bindable functions and bindable events. This can be used to communicate between modulescripts without having to directly reference each other. This becomes
important to reduce complications arising from high coupling. Requiring other modules under a parent folder that is not a package should be using bindables. This is also used to prevent
cyclic dependencies, as well as cascading failure.
```lua
local Dispatcher = _G.include "%Dispatcher";

Dispatcher:Connect("print_hello_world", function()
      print "Hello World!";
end)

Dispatcher:Fire("print_hello_world");
```
**Note:** Bindable functions can also be accessed and used in a similar manner via:
> :Bind(string_identifier, function)

> :Invoke(string_identifier, argument_1, argument_2, ...);

The **Components** module is modeled after Unity's component editor. In the case that the developer may have to edit values to influence the result of a script, the components module
can be used. This has two way communication, meaning that scripts modifying component attributes through the direct table will also update the physical folder where these attributes
can be accessed, and vice versa. 
```lua
local Components = _G.include "%Components";

local Dog = Components:Create("Dog", {
      Name = "John";
      Breed = "Labrador Retriever";
})

Dog.Name = "Bailey";                -- Updates via ReplicatedStorage.Components.Dog:SetAttribute("Name", "Bailey");
Dog.Breed = "German Sheperd";       -- Updates via ReplicatedStorage.Components.Dog:SetAttribute("Breed", "German Sheperd");
```  
**Note:** These physical attributes are stored under ***ReplicatedStorage*** under folder ***Components***. Creating a new component will create separate configuration folders, where
the passed keys and values will be stored as attributes in the properties panel.

## Module Organization
By default, the framework organizes modules via the interface (if on client), modules, packages, and the world folders. See below for information about each. 
**Note:** Developers wishing to update the names, add or delete folders, or restructure must update the start script. 

- **Interface:** Modules specific to modifying UI objects. Examples include: Custom Chat, Main Menu, Character Selector
- **Modules:** Code vital to game processes that are always running. Examples include: Camera, Character Controllers, Datastores, NPC Controllers
- **Packages:** Code meant to be used as a tool of code stored in the modules folder. They are standalone and should not be using the importer unless they are accessing the shared library.
- **World:** Anything pertaining to world objects can be stored in this folder. Examples include: Lighting, Interaction System, Vegetation
- **Libraries:** Same premise as shared folders and packages. Though these are specifically meant to be accessible by both the client and the server.

**Final Note:** Do not modify code stored within the Framework modules unless issues are found or the client and server folders are restructured.