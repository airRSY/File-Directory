--[[
	ESPLIBRARY
	
	A library that helps in the making of ESPs
]]--

---<< SERVICES >>---
local Players = game:GetService("Players")


---<< CONSTANTS >>---
local LocalPlayer = Players.LocalPlayer
shared.ESPFolder = shared.ESPFolder or Instance.new("Folder")


---<< INITIALIZE >>---
shared.ESPFolder.Parent = game:GetService("CoreGui")
local chamsFolder = Instance.new("Folder")
chamsFolder.Name = "Chams"
chamsFolder.Parent = shared.ESPFolder


---<< MODULE >>---
local ESPLibrary = {}
ESPLibrary.Instances = {
	Chams = {}
}

function ESPLibrary:NewChamESP(owner, isAPlayer)
	isAPlayer = isAPlayer or false

	local cham = {
		Objects = Instance.new("Highlight")
	}
	
	cham.Objects.Name = tostring(owner.Name)
	cham.Objects.Parent = chamsFolder
	
	if isAPlayer then
		cham.Objects.Adornee = owner.Character or owner
	else
		cham.Objects.Adornee = owner
	end
	
	ESPLibrary.Instances.Chams[owner.Name] = cham
	
	function cham:SetVisibility(boolean)
		cham.Objects.Enabled = boolean
	end
	
	function cham:Remove()
		cham.Objects:Destroy()
		ESPLibrary.Instances.Chams[owner.Name] = nil
	end
	
	return cham
end

function ESPLibrary:HasChamESP(owner)
	return ESPLibrary.Instances.Chams[owner.Name] ~= nil
end

function ESPLibrary:GetChamESP(owner)
	if ESPLibrary:HasChamESP(owner) then
		return ESPLibrary.Instances.Chams[owner.Name]
	end
end

return ESPLibrary
