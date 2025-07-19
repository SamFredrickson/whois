local SCRIPT_INFO = {
    AUTHOR = "SAM",
    VERSION = "1.0.0",
    MOONLOADER = 026,
    VERSION_NUMBER = 1,
    VERSION_URL = "https://raw.githubusercontent.com/SamFredrickson/whois/master/version.json",
    CHANGELOG_URL = "https://github.com/SamFredrickson/whois/blob/master/CHANGELOG.md",
    URL = "https://github.com/SamFredrickson/whois",
}

local URL = "https://logs.evolve-rp.com/saint-louis/journal"
local HEADERS = {
    ["content-type"]     = "application/x-www-form-urlencoded; charset=UTF-8",
    ["accept"]           = "application/json",
    ["x-requested-with"] = "XMLHttpRequest"
}
local COLUMNS = {
    [1] = "Организация",
    [2] = "Инициатор",
    [3] = "Объект",
    [4] = "Действие",
    [5] = "Старый ранг",
    [6] = "Новый ранг",
    [7] = "Причина",
    [8] = "Дата"
}

return {
    SCRIPT_INFO = SCRIPT_INFO,
    HEADERS = HEADERS,
    COLUMNS = COLUMNS,
    URL = URL
}