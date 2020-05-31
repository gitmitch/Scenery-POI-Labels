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

To setup your development environment:

1. Install [Lua](https://www.lua.org/) (for Mac, I recommend using [Homebrew](https://brew.sh/))
2. Install [Busted](https://olivinelabs.com/busted/) (I recommend installing using [Luarocks](https://luarocks.org/))

Running the tests
-----------------
