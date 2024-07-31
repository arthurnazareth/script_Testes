local job_Folder = game.Workspace:WaitForChild("jobs_Folder")
local job = job_Folder:FindFirstChild("charging_Assistant#job")

local all_box = job:FindFirstChild("boxs")
local box = all_box:GetChildren()

isCarrying = false
box_Color = nil

for _, boxs in ipairs(box) do
	for _, proximity in ipairs(boxs:GetChildren()) do
		if proximity:IsA("ProximityPrompt") then
			function proximityBox(player)
				isCarrying = true
				if isCarrying then
					local character = player.character
					local box = proximity.Parent
					local weld = Instance.new("Motor6D", character.HumanoidRootPart)
					weld.Part0 = box
					weld.Part1 = character.HumanoidRootPart
					weld.Name = "box_Weld"
	
					--configs
					box.CanCollide = false
					box.Anchored = false
	
					box_Color = box:FindFirstChild("box_Color").Value
					proximity.Enabled = false
				end
			end
			if isCarrying then
				proximity.Enabled = false
			end
		end
	end
	boxs:WaitForChild("ProximityPrompt").Triggered:Connect(proximityBox)
end

