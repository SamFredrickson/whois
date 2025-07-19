local encoding = require "encoding"
local constants = require "whois.constants"
local effil = require "effil"

script_author(constants.SCRIPT_INFO.AUTHOR)
script_version(constants.SCRIPT_INFO.VERSION)
script_moonloader(constants.SCRIPT_INFO.MOONLOADER)
script_version_number(constants.SCRIPT_INFO.VERSION_NUMBER)
script_url(constants.SCRIPT_INFO.URL)
script_name(constants.SCRIPT_INFO.NAME)

encoding.default = "CP1251"
local u8 = encoding.UTF8

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
        while not isSampAvailable() do wait(100) end

    sampAddChatMessage(
        " {FFFFFF}Команда - {ed5a5a}/whois{FFFFFF}, страница скрипта: {ed5a5a}" .. 
        thisScript().url, 0xFFFFFF
    )

    sampRegisterChatCommand
    (
        "whois",
        function(value)
            if value == nil or value == "" then
                sampAddChatMessage(" {ed5a5a}/whois{FFFFFF} [ID / Nickname]", 0xFFFFFF)
                return false
            end
            local id = tonumber(value:match("([0-9]+)"))
            if id and sampIsPlayerConnected(id) then
                local nickname = sampGetPlayerNickname(id)
                local message = string.format(" {ed5a5a}Поиск игрока {FFFFFF}%s...", nickname)
                sampAddChatMessage(message, 0xFFFFFF)
                sendHttpRequest
                (
                    "POST", 
                    constants.URL, 
                    { headers = constants.HEADERS, data = getPostData(nickname) },
                    function(response) handleSuccesfulResponse(response) end,
                    function(error) handleFailedResponse(error) end
                )
                return true
            end
            
            local nickname = value:match("([A-Za-z0-9_]+)")
            if not id and nickname then
                local message = string.format(" {ed5a5a}Поиск игрока {FFFFFF}%s...", nickname)
                sampAddChatMessage(message, 0xFFFFFF)
                sendHttpRequest
                (
                    "POST", 
                    constants.URL, 
                    { headers = constants.HEADERS, data = getPostData(nickname) },
                    function(response) handleSuccesfulResponse(response) end,
                    function(error) handleFailedResponse(error) end
                )
                return true
            end

            sampAddChatMessage(" {BABABA}Игрок не найден", 0xFFFFFF)
            return false
        end
    )

    wait(-1)
end

function sendHttpRequest(method, url, args, resolve, reject)
   local request_thread = effil.thread(function (method, url, args)
      local requests = require "requests"
      local result, response = pcall(requests.request, method, url, args)
      if result then
         response.json, response.xml = nil, nil
         return true, response
      else
         return false, response
      end
   end)(method, url, args)
   -- Если запрос без функций обработки ответа и ошибок.
   if not resolve then resolve = function() end end
   if not reject then reject = function() end end
   -- Проверка выполнения потока
   lua_thread.create(function()
      local runner = request_thread
      while true do
         local status, err = runner:status()
         if not err then
            if status == 'completed' then
               local result, response = runner:get()
               if result then
                  resolve(response)
               else
                  reject(response)
               end
               return
            elseif status == 'canceled' then
               return reject(status)
            end
         else
            return reject(err)
         end
         wait(0)
      end
   end)
end

function getPostData(nickname)
    return string.format("draw=0&columns[0][data]=0&columns[0][name]=&columns[0][searchable]=true&columns[0][orderable]=true&columns[0][search][value]=&columns[0][search][regex]=false&columns[1][data]=1&columns[1][name]=&columns[1][searchable]=true&columns[1][orderable]=true&columns[1][search][value]=&columns[1][search][regex]=false&columns[2][data]=2&columns[2][name]=&columns[2][searchable]=true&columns[2][orderable]=true&columns[2][search][value]=%s&columns[2][search][regex]=false&columns[3][data]=3&columns[3][name]=&columns[3][searchable]=true&columns[3][orderable]=true&columns[3][search][value]=&columns[3][search][regex]=false&columns[4][data]=4&columns[4][name]=&columns[4][searchable]=true&columns[4][orderable]=true&columns[4][search][value]=&columns[4][search][regex]=false&columns[5][data]=5&columns[5][name]=&columns[5][searchable]=true&columns[5][orderable]=true&columns[5][search][value]=&columns[5][search][regex]=false&columns[6][data]=6&columns[6][name]=&columns[6][searchable]=true&columns[6][orderable]=true&columns[6][search][value]=&columns[6][search][regex]=false&columns[7][data]=7&columns[7][name]=&columns[7][searchable]=true&columns[7][orderable]=true&columns[7][search][value]=&columns[7][search][regex]=false&order[0][column]=7&order[0][dir]=desc&start=0&length=1&search[value]=&search[regex]=false&fraction=0", nickname)
end

function handleSuccesfulResponse(response)
    local json = decodeJson(response.text)
    if json.data[1] == nil then
        sampAddChatMessage(" {BABABA}Поиск не дал результатов", 0xFFFFFF)
        return false
    end
    sampAddChatMessage("---========== Результаты Поиска ==========---", 0xFFFFFF)
    for index, value in pairs(json.data[1]) do
        if index == 1 then value = value:match("([A-Z]+)") end
        local message = string.format
        (
            " {ed5a5a}%s: {FFFFFF}%s", 
            constants.COLUMNS[index], 
            u8:decode(value)
        )
        sampAddChatMessage(message, 0xFFFFFF)
    end
end

function handleFailedResponse(error)
    sampAddChatMessage(" {ed5a5a}Произошла ошибка при попытке поиска", 0xFFFFFF)
    return false
end