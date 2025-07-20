local URL = "https://logs.evolve-rp.com/saint-louis/journal"

local SCRIPT_INFO = {
    AUTHOR = "SAM",
    VERSION = "1.1.0",
    MOONLOADER = 026,
    VERSION_NUMBER = 2,
    VERSION_URL = "https://raw.githubusercontent.com/SamFredrickson/whois/master/version.json",
    CHANGELOG_URL = "https://github.com/SamFredrickson/whois/blob/master/CHANGELOG.md",
    URL = "https://github.com/SamFredrickson/whois",
}

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

local FRACTIONS = {
    ["MAYOR"] = "Мэрия",
    ["FBI"]   = "Федеральное Бюро Расследований",
    ["MOH"]   = "Министерство Здравоохранения",
    ["LVA"]   = "Армия «Зона 51»",
    ["SFA"]   = "Армия «Авианосец»",
    ["LVPD"]  = "Полиция г. Лас-Вентурас",
    ["LSPD"]  = "Полиция г. Лос-Сантос",
    ["SFPD"]  = "Полиция г. Сан-Фиерро",
    ["DS"]    = "Автошкола г. Сан-Фиерро",
    ["SFN"]   = "Новости г. Сан-Фиерро",
    ["LSN"]   = "Новости г. Лос-Сантос",
    ["LVN"]   = "Новости г. Лас-Вентурас"
}

return {
    SCRIPT_INFO = SCRIPT_INFO,
    HEADERS = HEADERS,
    COLUMNS = COLUMNS,
    FRACTIONS = FRACTIONS,
    URL = URL
}