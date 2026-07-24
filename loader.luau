-- Loader.luau - This is what your users will run with one line
-- This file fetches the main script from the same repository

local mainScript = game:HttpGet("https://raw.githubusercontent.com/ItsZenRealYT/rivals-spoofer/main/main.luau")
loadstring(mainScript)()
