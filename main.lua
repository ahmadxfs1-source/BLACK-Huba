repeat
	task.wait()
until game:IsLoaded()

local cloneref = cloneref or function(Input)
	return Input
end

local CoreGui = cloneref(game:GetService("CoreGui"))
local HttpService = cloneref(game:GetService("HttpService"))
local RunService = cloneref(game:GetService("RunService"))
local TextService = cloneref(game:GetService("TextService"))
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Workspace = cloneref(game:GetService("Workspace"))

local InstanceNew = Instance.new

local IsMobile = UserInputService.TouchEnabled and (not UserInputService.KeyboardEnabled or not UserInputService.MouseEnabled)
local GameId = tostring(game.GameId)

local HubName = "BLACK-Hub"
local Directory = "blackhub"
local Folders = {"/Configs", "/Themes", "/Fonts", "/Luas", "/Assets", "/Images"}

local FontFaces = {
	SemiBold = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
}

local function PrepareWorkspace()
	if not (isfolder and makefolder and isfile and readfile and writefile) then return end

	if not isfolder(Directory) then
		makefolder(Directory)
	end

	for _, Value in Folders do
		local Path = Directory .. Value
		if not isfolder(Path) then
			makefolder(Path)
		end
	end

	for _, Value in {"Autoload.txt", "ThemeAutoload.txt"} do
		local Path = Directory .. "/" .. Value
		if not isfile(Path) then
			writefile(Path, "")
		end
	end
end

-- قائمة الألعاب ومعرفاتها
local GameList = {
	["994732206"] = { Id = "ce2e40f0bc2b1720" }, -- Blox Fruits
	["4777817887"] = { Id = "cf1e81c5fb14d3bc" }, -- Blade Ball
	-- أضف باقي الألعاب هنا إذا احتجت
}

-- رابط مجلد الـ scripts في مستودع BLACK-Hub الخاص بك
local ScriptBaseUrl = "https://raw.githubusercontent.com/ahmadxfs1-source/BLACK-Hub/main/scripts/"

PrepareWorkspace()

local GameConfig = GameList[GameId]

if not GameConfig then
	warn("[" .. HubName .. "] This game is not supported.")
	return
end

local ScriptId = GameConfig.Id
local LoaderUrl = ScriptBaseUrl .. ScriptId .. ".lua"

local Loaded, Error = pcall(function()
	local Source = game:HttpGet(LoaderUrl)
	local Chunk, LoadErr = loadstring(Source)
	assert(Chunk, LoadErr)
	Chunk()
end)

if not Loaded then
	warn("[" .. HubName .. "] Script failed: " .. tostring(Error))
end
