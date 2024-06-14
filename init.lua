--Variable global
ranker = {}
--Directorio del mod
local modpath = minetest.get_modpath("ranker")
local lfs = require("lfs")
--Enviar debug por consola
local log = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[Ranker]"..msg)
	end
end

local function getFilesInDirectory(dir)
    local files = {}
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            local filePath = dir .. "/" .. file
            local attr = lfs.attributes(filePath)
            if attr.mode == "file" then
                table.insert(files, filePath)
            elseif attr.mode == "directory" then
                local subFiles = getFilesInDirectory(filePath)
                for _, subFile in ipairs(subFiles) do
                    table.insert(files, subFile)
                end
            end
        end
    end
    return files
end

log("Cargando contenido...")
--Cargar mod
local script_dirs = {
    modpath,
    modpath .. "/metodos",
    modpath .. "/mods"
}

for _, dir in ipairs(script_dirs) do
    local files = getFilesInDirectory(dir)
    for _, file in ipairs(files) do
        dofile(file)
    end
end




