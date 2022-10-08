-- Time Based Debounce
-- Russel Costales
-- September 24, 2022

local TimeDebounce = {}
TimeDebounce.__index = TimeDebounce

function TimeDebounce.new(interval, reverse)
	return setmetatable({
		_sTime = os.clock(),
		_interval = interval,
		_reverse = reverse,
	}, TimeDebounce)
end

function TimeDebounce:Set()
	self._sTime = os.clock()
end

function TimeDebounce:Reset()
	self._sTime = -math.huge
end

function TimeDebounce:Verify()
	local result = os.clock() - self._sTime > self._interval
	if result then
		self._sTime = os.clock()
		
		return true
	end
end

return TimeDebounce