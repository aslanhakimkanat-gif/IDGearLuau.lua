local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")

-- Функция для выдачи вещи по ID
local function giveGearById(player: Player, assetId: number)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	local backpack = player:WaitForChild("Backpack") :: Backpack
	
	-- Пытаемся загрузить модель вещи по ID через InsertService
	local success, result = pcall(function()
		return InsertService:LoadAsset(assetId)
	end)
	
	if success and result then
		-- LoadAsset обычно возвращает Model, внутри которой лежит Tool
		local tool = result:FindFirstChildWhichIsA("Tool", true)
		
		if tool then
			-- Переносим инструмент в рюкзак игрока
			tool.Parent = backpack
			-- Сразу берем в руки
			humanoid:EquipTool(tool)
			
			-- Удаляем пустую модель-контейнер из workspace, если она там осталась
			result:Destroy()
			print("Вещь успешно выдана!")
		else
			warn("Внутри этого ID не найден объект Tool (возможно, это просто модель или одежда).")
			result:Destroy()
		end
	else
		warn("Не удалось загрузить вещь по ID: " .. tostring(result))
	end
end

-- ==========================================
-- ПРИМЕР ИСПОЛЬЗОВАНИЯ:
-- ==========================================
local targetPlayer = Players.LocalPlayer -- Если скрипт клиентский, либо замените на получение игрока на сервере
local gearIdToGive = 125013769 -- Сюда можно вписать ID любой вещи (например, 125013769 — это Linked Sword)

task.wait(2) -- Небольшая задержка, чтобы персонаж точно прогрузился
giveGearById(targetPlayer, gearIdToGive)
