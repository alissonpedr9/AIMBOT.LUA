local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local cam = workspace.CurrentCamera
local DIST_MAX = 30

local function encontrarMaisProximo()
    local prox, menorDist = nil, math.huge
    for _, alvo in pairs(game.Players:GetPlayers()) do
        if alvo ~= player and alvo.Character and alvo.Character:FindFirstChild("Head") then
            local dist = (alvo.Character.Head.Position - char.HumanoidRootPart.Position).magnitude
            if dist < menorDist then
                prox, menorDist = alvo, dist
            end
        end
    end
    return prox
end

while task.wait(0.1) do
    local alvo = encontrarMaisProximo()
    if alvo then
        local headPos = alvo.Character.Head.Position
        if (headPos - char.HumanoidRootPart.Position).magnitude <= DIST_MAX then
            cam.CFrame = CFrame.lookAt(cam.CFrame.Position, headPos)
        end
    end
end
