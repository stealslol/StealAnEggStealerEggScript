-- SWILL: Скрипт для мгновенного кражи яиц в Roblox "Steal an Egg" с поддержкой мобильных устройств

loadstring(game:HttpGet("https://raw.githubusercontent.com/SwillWay/EggStealer/main/EggStealerScript.lua"))()

-- Создаем интерфейс
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "EggStealerGUI"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 200)  -- Увеличиваем размер для добавления надписи
frame.Position = UDim2.new(0.5, -100, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Parent = gui

-- Добавляем надпись "maded by stealslol"
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 180, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.Text = "maded by stealslol"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1  -- Прозрачный фон
label.Parent = frame

local stealButton = Instance.new("TextButton")
stealButton.Size = UDim2.new(0, 180, 0, 50)
stealButton.Position = UDim2.new(0, 10, 0, 50)
stealButton.Text = "Steal Egg Instantly"
stealButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.8)
stealButton.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 180, 0, 50)
teleportButton.Position = UDim2.new(0, 10, 0, 110)
teleportButton.Text = "Teleport to Egg"
teleportButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0.4)
teleportButton.Parent = frame

-- Функция для мгновенного кражи яйца
local function stealEggInstantly()
    local eggs = workspace:FindFirstChild("Eggs")
    if eggs then
        for _, egg in pairs(eggs:GetChildren()) do
            if egg:IsA("BasePart") then
                egg.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
end

-- Функция для телепортации к ближайшему яйцу
local function teleportToEgg()
    local eggs = workspace:FindFirstChild("Eggs")
    if eggs then
        local closestEgg = nil
        local closestDistance = math.huge
        for _, egg in pairs(eggs:GetChildren()) do
            if egg:IsA("BasePart") then
                local distance = (player.Character.HumanoidRootPart.Position - egg.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestEgg = egg
                end
            end
        end
        if closestEgg then
            player.Character.HumanoidRootPart.CFrame = closestEgg.CFrame
        end
    end
end

-- Подключаем функции к кнопкам
stealButton.MouseButton1Click:Connect(stealEggInstantly)
teleportButton.MouseButton1Click:Connect(teleportToEgg)

-- Поддержка мобильных устройств
local function onTouchInput(input, gameProcessed)
    if not gameProcessed then
        local touchLocation = input.Position
        if stealButton.AbsolutePosition.X <= touchLocation.X and touchLocation.X <= stealButton.AbsolutePosition.X + stealButton.AbsoluteSize.X and
           stealButton.AbsolutePosition.Y <= touchLocation.Y and touchLocation.Y <= stealButton.AbsolutePosition.Y + stealButton.AbsoluteSize.Y then
            stealEggInstantly()
        elseif teleportButton.AbsolutePosition.X <= touchLocation.X and touchLocation.X <= teleportButton.AbsolutePosition.X + teleportButton.AbsoluteSize.X and
               teleportButton.AbsolutePosition.Y <= touchLocation.Y and touchLocation.Y <= teleportButton.AbsolutePosition.Y + teleportButton.AbsoluteSize.Y then
            teleportToEgg()
        end
    end
end

-- Подключаем обработчик касаний для мобильных устройств
game:GetService("UserInputService").TouchStarted:Connect(onTouchInput)

-- Дополнительные функции (по желанию)
-- Например, автоматическая кража яиц каждые 5 секунд
local function autoSteal()
    while true do
        wait(5)
        stealEggInstantly()
    end
end

-- Запуск автоматической кражи (раскомментируйте, если нужно)
-- spawn(autoSteal)
