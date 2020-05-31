POI Labels on Scenery - Plugin for X Plane
==========================================

This plugin for X Plane labels points of interest (POIs) on your scenery as you fly around. POIs are downloaded from OpenStreetMap automatically. These are the kinds of POIs the plugin labels:

* Mountains
* Rivers
* Population centers
* Airports

This plugin uses the [SASL plugin framework](https://1-sim.com/). All of the logic is implemented in [Lua](https://www.lua.org/). The [Busted](https://olivinelabs.com/busted/) test-driven-development framework is used for testing.

Development
===========

To setup your development environment, be sure to install Lua 5.1 so you're developing and testing with the same version of Lua that LuaJIT uses in X Plane (v5.1 as of X Plane 11.41). You'll also need [Busted](https://olivinelabs.com/busted/) for running tests and [LuaCov](https://keplerproject.github.io/luacov/) for test coverage analysis. Here's how I did it on my Mac (note: I tried an approach with Homebrew but was unsuccessful).

1. Install [hererocks](https://github.com/mpeterv/hererocks): `pip3 install hererocks` . You'll need Python and Pip to install it.
2. Make a directory somewhere for your installation of Lua, Luarocks, etc. (hererocks gave me an error for directories with a space in the path).
3. In that directory, `hererocks lua51 -l5.1 -rlatest` to install Lua 5.1 with the latest luarocks.
4. Activate that installation (add the necessary paths to your shell) with `source lua51/bin/activate`. You should also `source` this command in your .bashrc or .zshrc so that the paths are active each time you login.
5. `luarocks install busted`
6. `luarocks install luacov`

Running the tests
-----------------
```
cd data/modules/Custom\ Module
busted
```
Reviewing the test coverage report
----------------------------------

Again, in the `data/modules/Custom\ Module` directory:
```
luacov
cat luacov.report.out | more
```