# FS2020 - SimConnect PureBasic Bindings

A simple includes that provides bindings to a couple of the functions and structures present in the SimConnect API.

Only a very small amount of structures and functions are properly defined and tested, use this include at your own risk.


## Cloning

To clone this repo and the submodule it requires you have to use one of the following commands:

`git clone --recurse-submodules https://github.com/aziascreations/FS2020---SimConnect-PureBasic-Bindings.git`<br>
If you want to clone the whole repo without integrating it into an existing repository.

`aaa`<br>
If you want to clone it as a submodule inside an existing repository.


## Usage

### Importing

To include the pbi file in your code you just have to use `XIncludeFile "${Include Path}"` where `${Include Path}` can either be the absolute or relative path to said include.

Next, if you selected a custom location for the Flight Simulator SDK when you installed it, you can either manually modify the path in the pbi file or define a constant named `#SIMCONNECT_LIB_PATH` which contains the path to the `SimConnect.lib` file before including the pbi file.<br>
See "[Examples/CustomLibPath.pb]()" for an example on how to do this.

You should also keep in mind that the include uses the `EnableExplicit` compiler directive.

[Remark about wintypes, the license, why it is there and how to resolve the macros if needed !!!]

### Important remarks 

There are a couple of important remarks that need [to be made] regarding the way you need to call functions or how some structure works.

#### Functions

Some of the functions that require strings like `SimConnect_Open()` and `SimConnect_FlightPlanLoad()` won't work properly in PureBasic [due to...].<br>
To fix this issue, you need to need to work around PureBasic's unicode formatted strings like so:

For a function in C++<br>
`SIMCONNECTAPI SimConnect_FlightPlanLoad(HANDLE hSimConnect, const char * szFileName);`

Whose PB equivalent would be:<br>
`SimConnect_FlightPlanLoad(hSimConnect.HANDLE, szFileName.s)`

You have to actually treat the string a pointers like so:<br>
`SimConnect_FlightPlanLoad(hSimConnect.HANDLE, *szFileName)`

And call it like in this way:
```
Define *FileName = Ascii("MyFlightPlan")
SimConnect_FlightPlanLoad(hSimConnect, *FileName)
FreeMemory(*FileName)
```

A potential fix for this issue could be to see if the `.p-ascii` data type to force the compiler to do it for ourselve, but this is not guaranteed to work, this is something I will be looking into however.


#### Structures

[....]


## Building

### Dynamically linked apps

Just place the dll file present in the SDK in the same folder as your final or temporary executable.<br>
And don't forget to check the "*Create temporary executable in the source directory*" option in the "*Compiler options*" menu.

### Statically linked apps

You might be able to do it with the larger .lib file that is included in the SDK, but I couldn't get it to work.<br>
The linker kept throwing symbol errors.


## License

Code in this repo:<br>
[Unlicense](LICENSE)

SimConnect:<br>
I don't know, you will have to check.
