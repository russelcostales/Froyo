-- Time Based Debounce
-- Russel Costales
-- September 24, 2022

local Clock = {}
Clock.__index = Clock

function Clock.new(interval)
	return setmetatable({
		_sTime = os.clock(),
		_interval = interval,
	}, Clock)
end

function Clock:ForceSetLastTimeToCurrent()
	self._sTime = os.clock()
end

function Clock:ForceSetToSurpassed()
	self._sTime = -math.huge
end

function Clock:SurpassedTimeInterval()
	local result = os.clock() - self._sTime > self._interval
	if result then
		self._sTime = os.clock()
		return true
	end
end

return Clock