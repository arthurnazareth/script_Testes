local job_Folder = game.Workspace:WaitForChild("jobs_Folder")
local job = job_Folder:FindFirstChild("charging_Assistant#job")

local all_box = job:FindFirstChild("boxs")
local box = all_box:GetChildren()

local animation = script.Carry

isCarrying = false
box_Color = nil

local function disableAllPrompts()
    for _, boxs in ipairs(box) do
        for _, child in ipairs(boxs:GetChildren()) do
            if child:IsA("ProximityPrompt") then
                child.Enabled = false
            end
        end
    end
end

for _, boxs in ipairs(box) do
	for _, proximity in ipairs(boxs:GetChildren()) do
		if proximity:IsA("ProximityPrompt") then
			function proximityBox(player)
				isCarrying = true
				if isCarrying then
					local character = player.character
					local humanoid = character:FindFirstChildOfClass("Humanoid")
					local box = proximity.Parent
					--configs
					box.CanCollide = false
					box.Anchored = false

					local prompt = box.ProximityPrompt

					animTrack = humanoid:LoadAnimation(animation)
					animTrack:Play()



					local weld = Instance.new("Motor6D", character.HumanoidRootPart)
					--configs
					weld.Part0 = box
					weld.Part1 = character.HumanoidRootPart

					weld.C0 = CFrame.new(0, 0.3, 1.6)

					weld.Name = "box_Weld"

					box_Color = box:FindFirstChild("box_Color").Value
					disableAllPrompts()
				end
			end
		end
	end
	boxs:WaitForChild("ProximityPrompt").Triggered:Connect(proximityBox)
end
	


