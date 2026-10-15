local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "EggStealerGUI"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 200)
frame.Position = UDim2.new(0.5, -100, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 180, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.Text = "maded by stealslol"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
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

stealButton.MouseButton1Click:Connect(stealEggInstantly)
teleportButton.MouseButton1Click:Connect(teleportToEgg)

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

game:GetService("UserInputService").TouchStarted:Connect(onTouchInput)

local function autoSteal()
    while true do
        wait(5)
        stealEggInstantly()
    end
end
