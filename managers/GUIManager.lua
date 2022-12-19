---<<< GUIManager >>>---
---<< SERVICES >>---
local GuiService = game:GetService("GuiService")


---<< CONSTANTS >>---
shared.ASYExploitRepos = "https://raw.githubusercontent.com/ASYExploit/ASYExploit-Hub/pre-alpha/"
local PlayerESPManager = loadstring(game:HttpGet(_G.ASYExploitRepos .. "managers/PlayerESPManager.lua"))()

local LinoriaRepository = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/"
local LinoriaLibrary = loadstring(game:HttpGet(LinoriaRepository .. "Library.lua"))
local LinoriaSaveManager = loadstring(game:HttpGet(LinoriaRepository .. "addons/SaveManager.lua"))
local LinoriaThemeManager = loadstring(game:HttpGet(LinoriaRepository .. "addons/ThemeManager.lua"))


---<< MODULE >>---
local GUIManager = {}

GUIManager.PlayerESPManager = PlayerESPManager
GUIManager.ESPLibrary = PlayerESPManager.ESPLibrary
GUIManager.LinoriaLibrary = LinoriaLibrary
GUIManager.SaveManager = LinoriaSaveManager
GUIManager.ThemeManager = LinoriaThemeManager

function GUIManager:BuildSettingsTab(window, gameFolderName)
	local Tab = window:AddTab("Settings")
	
	local MenuBox = Tab:AddLeftGroupbox("Menu")
	
	MenuBox:AddButton("Unload", function()
		LinoriaLibrary:Unload()
	end)
	MenuBox:AddLabel("Toggle GUI Keybind"):AddKeyPicker("SETTINGS.TOGGLEKEYBIND", {
		Text = "Toggle GUI Keypicker",
		Default = "RightControl",
		NoUI = true
	})
	LinoriaLibrary.ToggleKeybind = Options["SETTINGS.TOGGLEKEYBIND"]
	
	LinoriaThemeManager:SetLibrary(LinoriaLibrary)
	LinoriaSaveManager:SetLibrary(LinoriaLibrary)
	
	LinoriaSaveManager:IgnoreThemeSettings()
	LinoriaSaveManager:SetIgnoreIndexes({"SETTINGS.TOGGLEKEYBIND"})
	
	LinoriaThemeManager:SetFolder("ASYExploit")
	LinoriaSaveManager:SetFolder("ASYExploit/" .. tostring(gameFolderName))
	
	LinoriaThemeManager:ApplyToTab(Tab)
	LinoriaSaveManager:BuildConfigSection(Tab)
		
	return Tab, MenuBox
end


return GUIManager
