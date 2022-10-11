-- Time Based Debounce
-- Russel Costales
-- September 24, 2022

local Clock = {}
Clock.__index = Clock

function Clock.new(interval, reverse)
	return setmetatable({
		_sTime = os.clock(),
		_interval = interval,
		_reverse = reverse,
	}, Clock)
end

function Clock:Set()
	self._sTime = os.clock()
end

function Clock:Reset()
	self._sTime = -math.huge
end

function Clock:Verify()
	local result = os.clock() - self._sTime > self._interval
	if result then
		self._sTime = os.clock()
		
		return true
	end
end

return Clock