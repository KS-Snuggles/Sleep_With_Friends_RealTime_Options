function mpSleep()
	local player = getPlayer()
	if player:isAsleep() then
		if  LoopCheck == 1 then
			local modFatigue = (modFatigue - subFatThree)
			local modEndurance = (modEndurance + addEndur)
			player:getStats():setFatigue(modFatigue)
			player:getStats():setEndurance(modEndurance)
			if player:getStats():getFatigue() <= 0 and AutoWake == 1 then
				local LoopCheck = 0
				player:forceAwake()
			elseif player:getStats():getFatigue() <= 0 and AutoWake == 2 then
				player:getStats():setFatigue(0)
			else
			end
		elseif LoopCheck == 0 then
			local serverDayLength = (SandboxVars.DayLength - 2)
			local modFatigue = player:getStats():getFatigue()
			local modEndurance = player:getStats():getEndurance()
			local AutoWake = SandboxVars.SleepWithFriends.AutoWake
			local subFatOne = (24 / serverDayLength)
			local subFatTwo = (1 / subFatOne)
			local subFatThree = (subFatTwo / SandboxVars.SleepWithFriends.TestOption)
			local addEndur = (subFatThree * 2)
			local LoopCheck = 1
		end
	else
		local LoopCheck = 0
	end
end
Events.EveryOneMinute.Add(mpSleep)
