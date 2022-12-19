--[[
	PLAYERESPMANAGER
	
	Manages the player part of esp.
]]--

---<< SERVICES >>---
local Players = game:GetService("Players")


---<< LIBRARIES >>---
local ESPLibrary = loadstring(game:HttpGet(shared.ASYExploitRepos .. "libraries/ESPLibrary.lua"))()


---<< CONSTANTS >>---
local LocalPlayer = Players.LocalPlayer


---<< MODULE >>---
local PlayerESPManager = {}

PlayerESPManager.ESPLibrary = ESPLibrary
PlayerESPManager.Library = nil
PlayerESPManager.Settings = {
	Enabled = true,
	EnableKeybind = "V",
	TeamCheck = false,
	TeamColor = false,
	ShowSelf = true,
	Cham = {
		Enabled = true,
		AlwaysOnTop = true,
		FillColor = Color3.fromRGB(255, 0, 0),
		OutlineColor = Color3.fromRGB(255, 255, 255),
		FillTransparency = 0.5,
		OutlineTransparency = 0
	}
}

function PlayerESPManager:SetLibrary(library)
	PlayerESPManager.Library = library
end

function PlayerESPManager:BuildTab(Window)
	local ESPTab = Window:AddTab("ESP")
	
	local PlayerGroupbox = ESPTab:AddLeftGroupbox("Player")
	local PlayerESPBox = ESPTab:AddLeftTabbox("ESP Types")
	local ChamBox = PlayerESPBox:AddTab("Cham")
	
	PlayerESPManager:AddDivider()
	PlayerGroupbox:AddToggle("ESP_PLAYER_ENABLED", {
		Text = "ESP Enabled",
		Default = PlayerESPManager.Settings.Enabled,
		Tooltip = "Enable it to show ESPs."
	}):AddKeyPicker("ESP_PLAYER_ENABLEKEYBIND", {
		Text = "Enable ESP Keybind",
		Default = PlayerESPManager.Settings.EnableKeybind,
		Mode = "Toggle",
		SyncToggleState = true
	})
	PlayerGroupbox:AddToggle("ESP_PLAYER_TEAMCHECK", {
		Text = "Team Check",
		Default = PlayerESPManager.Settings.TeamCheck,
		Tooltip = "Color players green if they are your teammate."
	})
	PlayerGroupbox:AddToggle("ESP_PLAYER_TEAMCOLOR", {
		Text = "Team Color",
		Default = PlayerESPManager.Settings.TeamColor,
		Tooltip = "Set players esp color to their own team color."
	})
	PlayerGroupbox:AddToggle("ESP_PLAYER_SHOWSELF", {
		Text = "Show ESP Self",
		Default = PlayerESPManager.Settings.ShowSelf,
		Tooltip = "Show esp for yourself."
	})
	
	ChamBox:AddDivider()
	ChamBox:AddToggle("ESP_PLAYER_CHAM_ENABLED", {
		Text = "Cham Enabled",
		Default = PlayerESPManager.Settings.Cham.Enabled,
		Tooltip = "Enable it to show Cham ESP."
	})
	ChamBox:AddToggle("ESP_PLAYER_CHAM_ALWAYSONTOP", {
		Text = "Always On Top",
		Default = PlayerESPManager.Settings.Cham.AlwaysOnTop,
		Tooltip = "Set cham esp to be always on top of everything."
	})
	ChamBox:AddDivider()
	ChamBox:AddLabel("Fill Color"):AddColorPicker("ESP_PLAYER_CHAM_FILLCOLOR", {
		Title = "Cham Fill Color",
		Default = PlayerESPManager.Settings.Cham.FillColor
	})
	ChamBox:AddLabel("Outline Color"):AddColorPicker("ESP_PLAYER_CHAM_OUTLINECOLOR", {
		Title = "Outline Fill Color",
		Default = PlayerESPManager.Settings.Cham.OutlineColor
	})
	ChamBox:AddSlider("ESP_PLAYER_CHAM_FILLTRANSPARENCY", {
		Text = "Fill Transparency",
		Default = PlayerESPManager.Settings.Cham.FillTransparency,
		Min = 0,
		Max = 1,
		Rounding = 2
	})
	ChamBox:AddSlider("ESP_PLAYER_CHAM_OUTLINETRANSPARENCY", {
		Text = "Outline Transparency",
		Default = PlayerESPManager.Settings.Cham.OutlineTransparency,
		Min = 0,
		Max = 1,
		Rounding = 2
	})
	
	do
		Toggles["ESP_PLAYER_ENABLED"]:OnChanged(function()
			PlayerESPManager.Settings.Enabled = Toggles["ESP_PLAYER_ENABLED"].Value
		end)
		Toggles["ESP_PLAYER_TEAMCHECK"]:OnChanged(function()
			PlayerESPManager.Settings.TeamCheck = Toggles["ESP_PLAYER_TEAMCHECK"].Value
		end)
		Toggles["ESP_PLAYER_TEAMCHECK"]:OnChanged(function()
			PlayerESPManager.Settings.TeamColor = Toggles["ESP_PLAYER_TEAMCHECK"].Value
		end)
		Toggles["ESP_PLAYER_SHOWSELF"]:OnChanged(function()
			PlayerESPManager.Settings.ShowSelf = Toggles["ESP_PLAYER_SHOWSELF"].Value
		end)
		Toggles["ESP_PLAYER_CHAM_ENABLED"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.Enabled = Toggles["ESP_PLAYER_CHAM_ENABLED"].Value
		end)
		Toggles["ESP_PLAYER_CHAM_ALWAYSONTOP"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.AlwaysOnTop = Toggles["ESP_PLAYER_CHAM_ALWAYSONTOP"].Value
		end)
		Options["ESP_PLAYER_CHAM_FILLCOLOR"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.FillColor = Options["ESP_PLAYER_CHAM_FILLCOLOR"].Value
		end)
		Options["ESP_PLAYER_CHAM_OUTLINECOLOR"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.OutlineColor = Options["ESP_PLAYER_CHAM_OUTLINECOLOR"].Value
		end)
		Options["ESP_PLAYER_CHAM_FILLTRANSPARENCY"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.FillTransparency = Options["ESP_PLAYER_CHAM_FILLTRANSPARENCY"].Value
		end)
		Options["ESP_PLAYER_CHAM_OUTLINETRANSPARENCY"]:OnChanged(function()
			PlayerESPManager.Settings.Cham.OutlineTransparency = Options["ESP_PLAYER_CHAM_OUTLINETRANSPARENCY"].Value
		end)
	end
	
	return ESPTab
end

function PlayerESPManager:Update()
	for _, player: Player in pairs(Players:GetPlayers()) do
		if not PlayerESPManager.Settings.ShowSelf and player == LocalPlayer then
			continue
		end
		
		local character = player.Character
		if not character then
			continue
		end
		
		local cham = ESPLibrary:GetChamESP(player) or ESPLibrary:NewChamESP(player, true)
		
		if PlayerESPManager.Settings.Cham.Enabled then
			cham:SetVisibility(true)
			
			local object = cham.Objects
			
			if player == LocalPlayer then
				object.FillTransparency = 1
				object.OutlineTransparency = 0.9999999
				object.OutlineColor = Color3.fromRGB(255, 255, 255)
			else
				object.FillColor = PlayerESPManager.Settings.Cham.FillColor
				object.OutlineColor = PlayerESPManager.Settings.Cham.OutlineColor
				object.FillTransparency = PlayerESPManager.Settings.Cham.FillTransparency
				object.OutlineTransparency = PlayerESPManager.Settings.Cham.OutlineTransparency
			end
			
			local depthMode = PlayerESPManager.Settings.Cham.AlwaysOnTop
				and Enum.HighlightDepthMode.AlwaysOnTop
				or Enum.HighlightDepthMode.Occluded
			
			object.DepthMode = depthMode
			
			if object.Adornee ~= character then
				object.Adornee = character
			end
		else
			cham:SetVisibility(false)
		end
	end
end

function PlayerESPManager:Remove(player)
	local cham = ESPLibrary:GetChamESP(player)
	if cham then
		cham:Remove()
	end
end

return PlayerESPManager
