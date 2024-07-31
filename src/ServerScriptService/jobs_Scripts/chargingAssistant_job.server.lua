local job_Folder = game.Workspace:WaitForChild("jobs_Folder")
local job = job_Folder:FindFirstChild("charging_Assistant#job")

local all_box = job:FindFirstChild("boxs")
local box = all_box:GetChildren()

for _, boxs in ipairs(box) do
	box = boxs
	print(box)
end

function proximityBox(player)
end





