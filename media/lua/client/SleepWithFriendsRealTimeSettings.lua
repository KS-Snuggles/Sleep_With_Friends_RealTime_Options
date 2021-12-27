function mpSleep()
    local player = getPlayer()
    local modData = player:getModData()
	if player:isAsleep() then
		if  modData.swfLoopCheck == 1 then
			modData.swfFatigue = (modData.swfFatigue - modData.swfFatThree)
			modData.swfEndurance = (modData.swfEndurance + modData.swfEndur)
			player:getStats():setFatigue(math.max(0, modData.swfFatigue))
			player:getStats():setEndurance(math.min(1, modData.swfEndurance))
			player:getStats():setBoredom(modData.swfBoredom)
			player:getStats():setMorale(modData.swfSadness)
			if player:getStats():getFatigue() <= 0 and modData.swfAutoWake == 1 then
				modData.swfLoopCheck = 0
				player:forceAwake()
			else
			end
        elseif modData.swfLoopCheck == 0 then
			modData.swfServerDayLength = (SandboxVars.DayLength - 2)
			modData.swfFatigue = player:getStats():getFatigue()
			modData.swfEndurance = player:getStats():getEndurance()
			modData.swfBoredom = player:getStats():getBoredom()
			modData.swfSadness = player:getStats():getMorale()
			modData.swfAutoWake = SandboxVars.SleepWithFriends.AutoWake
			modData.swfFatOne = (24 / modData.swfServerDayLength)
			modData.swfFatTwo = (1 / modData.swfFatOne)
			modData.swfFatThree = (modData.swfFatTwo / SandboxVars.SleepWithFriends.SleepLength)
			modData.swfEndur = (modData.swfFatThree * SandboxVars.SleepWithFriends.EndurMulti)
			modData.swfLoopCheck = 1
		end
	else
		modData.swfLoopCheck = 0
	end
end
Events.EveryOneMinute.Add(mpSleep)
