return function(humanoid)
      --[[
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
      humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
      ]]
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
end