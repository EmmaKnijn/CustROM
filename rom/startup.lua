local completion = require "cc.shell.completion"

-- Setup paths
local sPath = ".:/rom/programs"
if term.isColor() then
    sPath = sPath .. ":/rom/programs/advanced"
end
if turtle then
    sPath = sPath .. ":/rom/programs/turtle"
else
    sPath = sPath .. ":/rom/programs/rednet:/rom/programs/fun"
    if term.isColor() then
        sPath = sPath .. ":/rom/programs/fun/advanced"
    end
end
if pocket then
    sPath = sPath .. ":/rom/programs/pocket"
end
if commands then
    sPath = sPath .. ":/rom/programs/command"
end
if http then
    sPath = sPath .. ":/rom/programs/http"
end
sPath = sPath .. ":/rom/community/programs"
shell.setPath(sPath)
help.setPath("/rom/help")

-- Setup aliases
shell.setAlias("ls", "list")
shell.setAlias("dir", "list")
shell.setAlias("cp", "copy")
shell.setAlias("mv", "move")
shell.setAlias("rm", "delete")
shell.setAlias("clr", "clear")
shell.setAlias("rs", "redstone")
shell.setAlias("sh", "shell")
if term.isColor() then
    shell.setAlias("background", "bg")
    shell.setAlias("foreground", "fg")
end

-- Setup completion functions

local function completePastebinPut(shell, text, previous)
    if previous[2] == "put" then
        return fs.complete(text, shell.dir(), true, false)
    end
end

local function completeConfigPart2(shell, text, previous)
    if previous[2] == "get" or previous[2] == "set" then
        return completion.choice(shell, text, previous, config.list(), previous[2] == "set")
    end
end

local function completeConfigPart3(shell, text, previous)
    if previous[2] == "set" then
        if config.getType(previous[3]) == "boolean" then return completion.choice(shell, text, previous, {"true", "false"})
        elseif previous[3] == "mount_mode" then return completion.choice(shell, text, previous, {"none", "ro", "ro_strict", "rw"}) end
    end
end

shell.setCompletionFunction("rom/programs/alias.lua", completion.build(nil, completion.program))
shell.setCompletionFunction("rom/programs/cd.lua", completion.build(completion.dir))
shell.setCompletionFunction("rom/programs/clear.lua", completion.build({ completion.choice, { "screen", "palette", "all" } }))
shell.setCompletionFunction("rom/programs/copy.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("rom/programs/delete.lua", completion.build({ completion.dirOrFile, many = true }))
shell.setCompletionFunction("rom/programs/drive.lua", completion.build(completion.dir))
shell.setCompletionFunction("rom/programs/edit.lua", completion.build(completion.file))
shell.setCompletionFunction("rom/programs/eject.lua", completion.build(completion.peripheral))
shell.setCompletionFunction("rom/programs/gps.lua", completion.build({ completion.choice, { "host", "host ", "locate" } }))
shell.setCompletionFunction("rom/programs/help.lua", completion.build(completion.help))
shell.setCompletionFunction("rom/programs/id.lua", completion.build(completion.peripheral))
shell.setCompletionFunction("rom/programs/label.lua", completion.build(
    { completion.choice, { "get", "get ", "set ", "clear", "clear " } },
    completion.peripheral
))
shell.setCompletionFunction("rom/programs/list.lua", completion.build(completion.dir))
shell.setCompletionFunction("rom/programs/mkdir.lua", completion.build({ completion.dir, many = true }))

local complete_monitor_extra = { "scale" }
shell.setCompletionFunction("rom/programs/monitor.lua", completion.build(
    function(shell, text, previous)
        local choices = completion.peripheral(shell, text, previous, true)
        for _, option in pairs(completion.choice(shell, text, previous, complete_monitor_extra, true)) do
            choices[#choices + 1] = option
        end
        return choices
    end,
    function(shell, text, previous)
        if previous[2] == "scale" then
            return completion.peripheral(shell, text, previous, true)
        else
            return completion.programWithArgs(shell, text, previous, 3)
        end
    end,
    {
        function(shell, text, previous)
            if previous[2] ~= "scale" then
                return completion.programWithArgs(shell, text, previous, 3)
            end
        end,
        many = true,
    }
))

shell.setCompletionFunction("rom/programs/move.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("rom/programs/redstone.lua", completion.build(
    { completion.choice, { "probe", "set ", "pulse " } },
    completion.side
))
shell.setCompletionFunction("rom/programs/rename.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("rom/programs/shell.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("rom/programs/type.lua", completion.build(completion.dirOrFile))
shell.setCompletionFunction("rom/programs/set.lua", completion.build({ completion.setting, true }))
shell.setCompletionFunction("rom/programs/advanced/bg.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("rom/programs/advanced/fg.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("rom/programs/fun/dj.lua", completion.build(
    { completion.choice, { "play", "play ", "stop " } },
    completion.peripheral
))
shell.setCompletionFunction("rom/programs/fun/speaker.lua", completion.build(
    { completion.choice, { "play ", "stop " } },
    function(shell, text, previous)
        if previous[2] == "play" then return completion.file(shell, text, previous, true)
        elseif previous[2] == "stop" then return completion.peripheral(shell, text, previous, false)
        end
    end,
    function(shell, text, previous)
        if previous[2] == "play" then return completion.peripheral(shell, text, previous, false)
        end
    end
))
shell.setCompletionFunction("rom/programs/fun/advanced/paint.lua", completion.build(completion.file))
shell.setCompletionFunction("rom/programs/http/pastebin.lua", completion.build(
    { completion.choice, { "put ", "get ", "run " } },
    completePastebinPut
))
shell.setCompletionFunction("rom/programs/http/gist.lua", completion.build(
    { completion.choice, { "put ", "get ", "run ", "edit ", "info ", "delete " } },
    completePastebinPut
))
shell.setCompletionFunction("rom/programs/rednet/chat.lua", completion.build({ completion.choice, { "host ", "join " } }))
shell.setCompletionFunction("rom/programs/command/exec.lua", completion.build(completion.command))
shell.setCompletionFunction("rom/programs/http/wget.lua", completion.build({ completion.choice, { "run " } }))

if periphemu and config and mounter then
    shell.setCompletionFunction("rom/programs/attach.lua", completion.build(
        completion.peripheral,
        { completion.choice, periphemu.names() }
    ))
    shell.setCompletionFunction("rom/programs/detach.lua", completion.build(completion.peripheral))
    shell.setCompletionFunction("rom/programs/config.lua", completion.build(
        { completion.choice, { "get ", "set ", "list " } },
        completeConfigPart2,
        completeConfigPart3
    ))
    shell.setCompletionFunction("rom/programs/mount.lua", completion.build(completion.dir))
    shell.setCompletionFunction("rom/programs/unmount.lua", completion.build(completion.dir))
end

if turtle then
    shell.setCompletionFunction("rom/programs/turtle/go.lua", completion.build(
        { completion.choice, { "left", "right", "forward", "back", "down", "up" }, true, many = true }
    ))
    shell.setCompletionFunction("rom/programs/turtle/turn.lua", completion.build(
        { completion.choice, { "left", "right" }, true, many = true }
    ))
    shell.setCompletionFunction("rom/programs/turtle/equip.lua", completion.build(
        nil,
        { completion.choice, { "left", "right" } }
    ))
    shell.setCompletionFunction("rom/programs/turtle/unequip.lua", completion.build(
        { completion.choice, { "left", "right" } }
    ))
end

-- Run autorun files
if fs.exists("/rom/autorun") and fs.isDir("/rom/autorun") then
    local tFiles = fs.list("/rom/autorun")
    for _, sFile in ipairs(tFiles) do
        if string.sub(sFile, 1, 1) ~= "." then
            local sPath = "/rom/autorun/" .. sFile
            if not fs.isDir(sPath) then
                shell.run(sPath)
            end
        end
    end
end

local function findStartups(sBaseDir)
    local tStartups = nil
    local sBasePath = "/" .. fs.combine(sBaseDir, "startup")
    local sStartupNode = shell.resolveProgram(sBasePath)
    if sStartupNode then
        tStartups = { sStartupNode }
    end
    -- It's possible that there is a startup directory and a startup.lua file, so this has to be
    -- executed even if a file has already been found.
    if fs.isDir(sBasePath) then
        if tStartups == nil then
            tStartups = {}
        end
        for _, v in pairs(fs.list(sBasePath)) do
            local sPath = "/" .. fs.combine(sBasePath, v)
            if not fs.isDir(sPath) then
                tStartups[#tStartups + 1] = sPath
            end
        end
    end
    return tStartups
end

-- Show MOTD
if settings.get("motd.enable") then
    shell.run("motd")
end

-- Run startup passed with --script if available
if _CCPC_STARTUP_SCRIPT then
    local fn, err = load(_CCPC_STARTUP_SCRIPT, "@startup.lua", "t", _ENV)
    if fn then
        local args = {}
        if _CCPC_STARTUP_ARGS then for n in _CCPC_STARTUP_ARGS:gmatch("[^ ]+") do table.insert(args, n) end end
        fn(table.unpack(args))
    else printError("Could not load startup script: " .. err) end
end

-- Run the user created startup, either from disk drives or the root
local tUserStartups = nil
if settings.get("shell.allow_startup") then
    tUserStartups = findStartups("/")
end
if settings.get("shell.allow_disk_startup") then
    for _, sName in pairs(peripheral.getNames()) do
        if disk.isPresent(sName) and disk.hasData(sName) then
            local startups = findStartups(disk.getMountPath(sName))
            if startups then
                tUserStartups = startups
                break
            end
        end
    end
end
if tUserStartups then
    for _, v in pairs(tUserStartups) do
        shell.run(v)
    end
end

if _CCPC_PLUGIN_ERRORS and settings.get("shell.report_plugin_errors") then
    printError("Some plugins failed to load:")
    for k,v in pairs(_CCPC_PLUGIN_ERRORS) do
        printError("  " .. k .. " - " .. v)
    end
end

_G.package.path = _G.package.path..settings.get("shell.append_path")