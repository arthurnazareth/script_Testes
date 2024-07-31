local Players = game:GetService("Players")

function statsCreate(player)
    local leaderStats = Instance.new("Folder")
    --configs
          leaderStats.Name = "leaderstats"
          leaderStats.Parent = player

    local Level = Instance.new("IntValue")
    --configs
          Level.Name = "Level"
          Level.Parent = leaderStats

    local toonCredits = Instance.new("IntValue")
    --configs
          toonCredits.Name = "toonCredits"  
          toonCredits.Parent = leaderStats

    local toonMoney = Instance.new("IntValue")
          --configs
          toonMoney.Name = "toonMoney"  
          toonMoney.Parent = leaderStats
end

Players.PlayerAdded:Connect(statsCreate)