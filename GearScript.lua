local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local player = Players.LocalPlayer

-- Вместо 125013769 укажите ID любой нужной вам вещи (Gear)
local gearId = 125013769 

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local backpack = player:WaitForChild("Backpack")

local success, result = pcall(function()
	return InsertService:LoadAsset(gearId)
end)

if success and result then
	local tool = result:FindFirstChildWhichIsA("Tool", true)
	if tool then
		tool.Parent = backpack
		humanoid:EquipTool(tool)
		result:Destroy()
		print("Вещь успешно выдана в Delta!")
	else
		warn("По этому ID не найден инструмент (Tool)!")
		result:Destroy()
	end
else
	warn("Ошибка загрузки вещи (возможно, игра блокирует InsertService): " .. tostring(result))
end
