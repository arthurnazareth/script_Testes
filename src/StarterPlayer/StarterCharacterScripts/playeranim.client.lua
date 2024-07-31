local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local uis = game:GetService("UserInputService")

local Walkanimation = Instance.new("Animation")
Walkanimation.AnimationId = "rbxassetid://18726668087"
local WalkTrack = humanoid:LoadAnimation(Walkanimation)

local isWalking = false

local function startAnim()
    if not isWalking then
        isWalking = true
        WalkTrack:Play()
    end
end

local function stopAnim()
    if isWalking then
        isWalking = false
        WalkTrack:Stop()
    end
end

local function UserinputConfig(input, isPressed)
    if input.KeyCode == Enum.KeyCode.W or
       input.KeyCode == Enum.KeyCode.A or
       input.KeyCode == Enum.KeyCode.S or
       input.KeyCode == Enum.KeyCode.D then
       if isPressed then
          startAnim()
       else
           local AnyKeyIsPressed = uis:IsKeyDown(Enum.KeyCode.W) or
                                   uis:IsKeyDown(Enum.KeyCode.A) or
                                   uis:IsKeyDown(Enum.KeyCode.S) or
                                   uis:IsKeyDown(Enum.KeyCode.D)
           if not AnyKeyIsPressed then
               stopAnim() 
           end                          
       end
    end               
end

uis.InputBegan:Connect(function(input)
    UserinputConfig(input, true)
end)

uis.InputEnded:Connect(function(input)
    UserinputConfig(input, false)
end)