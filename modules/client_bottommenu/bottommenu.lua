local bottomMenu
local calendarWindow = nil
local calendarEvents = {}
local showOffWindow
local activeScheduleEvent
local upcomingScheduleEvent
local selectedDate = os.date("*t")
local currentDate = os.date("*t")
local boostedWindow
local json = require("dkjson")
local api = "https://wiki.rookgaard.pl/api/"
local config = {
    monsterOfTheDay = nil,
    fetchCalendar = true,
    visibleMonths = 3,
    api = {
        calendar = function() return api .. 'calendar' end,
        motd = function () return api .. 'bonus/monster' end,
        monster = function (name) return api .. 'monster/' .. name .. '/fixera' end,
    }
}

local default_info = {
    [1] = {image = "images/randomhint", Title = "News",description = "Example News"},
}

function init()
    parseResponse(data)
    bottomMenu = g_ui.displayUI('bottommenu')  
    motd()
    calendarWindow = g_ui.displayUI("calendar")
    calendarWindow:setVisible(false)
    connect(g_game, {
        onGameStart = onGameStart,
        onGameEnd = onGameEnd
    })
    showOffWindow = bottomMenu:recursiveGetChildById('showOffWindow')
    showOffWindow.title = showOffWindow:recursiveGetChildById('showOffWindowText')
    activeScheduleEvent = bottomMenu:recursiveGetChildById('activeScheduleEvent')
    upcomingScheduleEvent = bottomMenu:recursiveGetChildById('upcomingScheduleEvent')
    if default_info then
        local widget = g_ui.createWidget('ShowOffWidget', showOffWindow)
        local description = widget:recursiveGetChildById('description')
        local image = widget:recursiveGetChildById('image')

        math.randomseed(os.time())
        local randomIndex = math.random(1, #default_info)
        local randomItem = default_info[randomIndex]
        showOffWindow.title:setText(tr(randomItem.Title))
        image:setImageSource(randomItem.image)
        description:setText(tr(randomItem.description))
    end
    if g_game.isOnline() then
        hide()
    end
end

function hide()
    bottomMenu:hide()
    bottomMenu:lower()
end

function show()
    bottomMenu:show()
    bottomMenu:raise()
    bottomMenu:focus()
end

function toggleCalendar()
    if type(calendarEvents) ~= "table" then
        calendarEvents = {}
    end

    if table.size(calendarEvents) == 0 and config.fetchCalendar then
        local calendarUrl = config.api.calendar()
        HTTP.getJSON(calendarUrl, parseResponse)
    else
        if calendarWindow:isVisible() then
            calendarWindow:hide()
        else
            buildMonth(0)
            calendarWindow:show()
            calendarWindow:raise()
            calendarWindow:centerIn('parent')
            calendarWindow:removeAnchor(AnchorHorizontalCenter)
            calendarWindow:removeAnchor(AnchorVerticalCenter)
        end
    end
end

function setShowOffData(data)
    local widget = g_ui.createWidget('ShowOffWidget', showOffWindow)
    local image = widget:recursiveGetChildById('image')

    if data.image and data.image:sub(1, 4):lower() == "http" then
        HTTP.downloadImage(data.image, function(path, err)
            if err then
                g_logger.warning("HTTP error: " .. err .. " - " .. data.image)
                return
            end
            image:setImageSource(path)
        end)
    else
        image:setImage(data.image)
    end

    local description = widget:recursiveGetChildById('description')

    showOffWindow.title:setText(tr(data.title))
    description:setText(tr(data.description))
end

function onClickCloseCalendar()
    calendarWindow:hide()
    calendarWindow:lower()
end

function motd()
    local function parseMonsterData(response)
        if not response then
            return
        end
        local jsonStart = response:find("{")
        if not jsonStart then
            return
        end
        local jsonResponse = response:sub(jsonStart)
        local decoded, pos, err = json.decode(jsonResponse, 1, nil)
        if err then
            return
        end
    if type(decoded) == "table" and decoded.look then
        config.monsterOfTheDay = decoded
        bottomMenu:recursiveGetChildById('boostLook'):setOutfit(config.monsterOfTheDay.look)
        bottomMenu:recursiveGetChildById('boostLook'):getCreature():setStaticWalking(1000)
    end
end

    local function parseMonsterName(response)
        if not response then
            return
        end
        
        config.monsterOfTheDay = {
            name = response:gsub('"', "")
        }
        bottomMenu:recursiveGetChildById('boostName'):setText(config.monsterOfTheDay.name)
        HTTP.get(config.api.monster(config.monsterOfTheDay.name), parseMonsterData)
    end
    HTTP.get(config.api.motd(), parseMonsterName)
end

local function checkCalendarDayIfExist(year, month, day)
    if (not calendarEvents[year]) then
        calendarEvents[year] = {}
    end
    
    if (not calendarEvents[year][month]) then
        calendarEvents[year][month] = {}
    end

    if (not calendarEvents[year][month][day]) then
        calendarEvents[year][month][day] = {}
    end
end

local function convertToTimestamp(date)
    local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    local runyear, runmonth, runday, runhour, runminute, runseconds = date:match(pattern)

    if (tonumber(runyear) < currentDate.year) then
        runyear = currentDate.year + tonumber(runyear)
    end

    return os.time({
        year = runyear,
        month = runmonth,
        day = runday,
        hour = runhour,
        min = runminute,
        sec = runseconds
    })
end

function parseResponse(data)
    if (not data or data == nil) then
        return
    end

    for _, values in pairs(data) do
        local fromDate = convertToTimestamp(values.fromDate)
        local toDate = values.toDate and convertToTimestamp(values.toDate) or fromDate
        for v = fromDate, toDate, 24 * 60 * 60 do
            local date = os.date('*t', v)
            checkCalendarDayIfExist(date.year, date.month, date.day)
            table.insert(
                calendarEvents[date.year][date.month][date.day],
                {
                    name = values.name,
                    color = values.color
                }
            )
        end
    end
    
    --activeScheduleEvent:clearEvents()
    local currentDay = os.date('*t', v)
    checkCalendarDayIfExist(currentDay.year, currentDay.month, currentDay.day)
    if #currentDay > 0 then
        for _, values in ipairs(currentDay[1]) do
            activeScheduleEvent:addScheduleEvent(event, true)
        end
    end
end

local function getMonthDays(year, month)
    local dateTable = { year = year, month = month + 1, day = 1, hour = 0 }
    local monthInfo = os.date("*t", os.time(dateTable))
    monthInfo.day = monthInfo.day - 1
    return os.date("*t", os.time(monthInfo))
end

local function createEvent(day, name, color, isOld)
    local event = g_ui.createWidget('CalendarEvent', day)
    event:setId(day.calendarDayName:getText() .. '-' .. name)
    event.calendarEventName:setText(name)
    if (color) then
        event:setImageColor(color)
    end
    if (isOld and day:getOpacity() == 1) then
        event:setOpacity(0.5)
    end 
end

local function getTimestamp(year, month, day)
    return os.time({ year = year, month = month, day = day })
end

local function addEventForDay(dayUI, year, month, day)
    if (calendarEvents[year]) then
        if (calendarEvents[year][month]) then
            local eventData = calendarEvents[year][month][day]
            if (eventData) then
                for _, data in pairs(eventData) do
                    local timestamp = getTimestamp(year, month, day)
                    local current = getTimestamp(currentDate.year, currentDate.month, currentDate.day)
                    createEvent(dayUI, data.name, data.color, timestamp < current)
                end
            end
        end
    end
end

function buildMonth(value)

    if (value ~= 0) then
        selectedDate.month = selectedDate.month + value
    else
        selectedDate = os.date('*t')
    end

    if (selectedDate.month < 1) then
        selectedDate.year = selectedDate.year - 1
        selectedDate.month = 12
    end

    if (selectedDate.month > 12) then
        selectedDate.year = selectedDate.year + 1
        selectedDate.month = 1
    end

    calendarWindow.selectionList:destroyChildren()

    local previousMonth = getMonthDays(selectedDate.year, selectedDate.month - 1)
    local previousMonthName = os.date("%b", os.time(previousMonth))
    local isMonday = false
    for i = previousMonth.day - 6, previousMonth.day do
        local day = os.time({
            year = previousMonth.year, month = previousMonth.month, day = i
        })
        if (tonumber(os.date('%w', day)) == 1) then
            isMonday = true
        end

        if (isMonday) then
            local day = g_ui.createWidget("CalendarDay", calendarWindow.selectionList)
            day:setId('prev' .. i)
            day.calendarDayName:setText(i .. ' ' .. previousMonthName .. (previousMonth.year ~= currentDate.year and ' ' .. previousMonth.year or ''))
            day:setOpacity(0.5)

            addEventForDay(day, previousMonth.year, previousMonth.month, i)
        end
    end
    if (previousMonth.year == currentDate.year and previousMonth.month < currentDate.month) then
        calendarWindow.previousMonth:disable()
        calendarWindow.previousMonth.previousMonthLabel:setImageClip(torect("0 0 12 21"))
    else
        calendarWindow.previousMonth:enable()
        calendarWindow.previousMonth.previousMonthLabel:setImageClip(torect("0 42 12 21"))
    end

    local currentMonth = getMonthDays(selectedDate.year, selectedDate.month)
    local currentMonthName = os.date("%b", os.time(currentMonth))
    local lastDayOfWeek = 0
    for i = 1, currentMonth.day do
        local day = g_ui.createWidget("CalendarDay", calendarWindow.selectionList)
        day:setId(i)
        day.calendarDayName:setText(i .. ' ' .. currentMonthName .. (currentMonth.year ~= currentDate.year and ' ' .. currentMonth.year or ''))
        if (i == currentDate.day and currentMonth.month == currentDate.month and currentMonth.year == currentDate.year) then
            day.calendarDayNameContainer:setImageColor('#ff4444')
            day:setBorderColor('#810000')
        end

        addEventForDay(day, currentMonth.year, currentMonth.month, i)

        if (i == currentMonth.day) then
            lastDayOfWeek = tonumber(os.date('%w', os.time(currentMonth)))
        end
    end

    local nextMonth = getMonthDays(selectedDate.year, selectedDate.month + 1)
    local nextMonthName = os.date("%b", os.time(nextMonth))
    for i = 1, (7 - lastDayOfWeek) do
        local day = g_ui.createWidget("CalendarDay", calendarWindow.selectionList)
        day:setId('next' .. i)
        day.calendarDayName:setText(i .. ' ' .. nextMonthName .. (nextMonth.year ~= currentDate.year and ' ' .. nextMonth.year or ''))
        day:setOpacity(0.5)
        addEventForDay(day, nextMonth.year, nextMonth.month, i)
    end

    local maxVisible = os.time(
        os.date(
        '*t',
        os.time({
            year = currentDate.year,
            month = currentDate.month + config.visibleMonths + 1,
            day = 1
        }))
    )
    if (os.time(nextMonth) >= maxVisible) then
        calendarWindow.nextMonth:disable()
        calendarWindow.nextMonth.nextMonthLabel:setImageClip(torect("12 0 12 21"))
    else
        calendarWindow.nextMonth:enable()
        calendarWindow.nextMonth.nextMonthLabel:setImageClip(torect("12 42 12 21"))
    end
end