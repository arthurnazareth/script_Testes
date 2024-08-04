local ContentProvider = game:GetService("ContentProvider")
local job_Folder = game.Workspace:WaitForChild("jobs_Folder")
local job = job_Folder:FindFirstChild("charging_Assistant#job")

local all_box = job:FindFirstChild("boxs")
local box = all_box:GetChildren()

local animation = script.Carry

isCarrying = false
box_Color = nil

old_box = nil
local cooldown = 5

local function cooldown_Box(timer)
	local cooldown_GUI = old_box.Timer
	local cooldown_Value = cooldown_GUI.timer_Value

	cooldown_Value.Value = cooldown
	while cooldown >= 0 do
		cooldown_GUI.text.Text = cooldown_Value.Value
		cooldown_GUI.Enabled = true

		task.wait(0.7)

		cooldown_Value.Value = cooldown_Value.Value - 1

		if cooldown_Value.Value == 0 then
			print("OI!")
			for _, boxs in ipairs(box) do
				for _, child in ipairs(boxs:GetChildren()) do
					if child:IsA("BillboardGui") then
						local timer_geral = child.timer_Value

						if timer_geral.Value == 0 then
							local gui_local = timer_geral:FindFirstAncestorOfClass("BillboardGui")
							print(gui_local)
						end
					end
				end	
			end
		end
	end
end

local function disableAllPrompts()
    for _, boxs in ipairs(box) do
        for _, child in ipairs(boxs:GetChildren()) do
            if child:IsA("ProximityPrompt") then
				if child.Name == "pegar_Prompt" and isCarrying then
                	child.Enabled = false
				end
            end
        end
    end
end

local function enableAllPrompts()
    for _, boxs in ipairs(box) do
        for _, child in ipairs(boxs:GetChildren()) do
            if child:IsA("ProximityPrompt") then
				if child.Name == "pegar_Prompt" and not isCarrying then
                	child.Enabled = true
				end
            end
        end
    end
end

function soltar_Box(player)
	local character = player.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local box_local = new_Prompt.Parent

	animTrack:Stop()
	isCarrying = false

	local weld = character.HumanoidRootPart:FindFirstChild("box_Weld")
	task.wait(0.3)
	weld:Destroy()

	if character then
		function onTouch(hit)
			if hit:IsA("Part") and hit.Position.Y <= box_local.Position.Y and not hit:IsDescendantOf(character) and box_local and not isCarrying then
				local box_local = new_Prompt.Parent

				local Timer = box_local.Timer
	
				box_local.CanCollide = true
				box_local.Anchored = true

				task.wait(0.4)
				enableAllPrompts()
				new_Prompt:Destroy()

				old_box = box_local
				cooldown_Box(Timer)
			end	
		end
	end
	if not isCarrying then
		box_local.Touched:Connect(onTouch)
	end
end

for _, boxs in ipairs(box) do
	for _, proximity in ipairs(boxs:GetChildren()) do
		if proximity:IsA("ProximityPrompt") then
			function proximityBox(player)
				isCarrying = true
				if isCarrying then
					local character = player.Character
					local humanoid = character:FindFirstChildOfClass("Humanoid")

					local box = proximity.Parent
					--configs
					box.CanCollide = false
					box.Anchored = false

					--anim play
					animTrack = humanoid:LoadAnimation(animation)
					animTrack:Play()


					local weld = Instance.new("Motor6D", character.HumanoidRootPart)
					--configs
					weld.Part0 = box
					weld.Part1 = character.HumanoidRootPart
					--weld posição relativa ao rootpart
					weld.C0 = CFrame.new(0, 0.3, 1.6)
					weld.Name = "box_Weld"

					--definir cor
					box_Color = box:FindFirstChild("box_Color").Value

					disableAllPrompts()

					new_Prompt = Instance.new("ProximityPrompt", box)
					new_Prompt.Name = "soltar_Prompt"
					--function
					new_Prompt.Triggered:Connect(soltar_Box)
				end
			end
		end
	end
	boxs:WaitForChild("pegar_Prompt").Triggered:Connect(proximityBox)
end