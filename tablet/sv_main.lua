CallCache = {}
EmergencyCache = {}
UnitCache = {}

CreateThread(function()
    while true do
        Wait(1000)
        CallCache = exports["sonorancad"]:GetCallCache()
        UnitCache = exports["sonorancad"]:GetUnitCache()
        for k, v in pairs(CallCache) do
            v.dispatch.units = {}
            if v.dispatch.idents then
                for ka, va in pairs(v.dispatch.idents) do
                    local unit
                    local unitId = exports["sonorancad"]:GetUnitById(va)
                    table.insert(v.dispatch.units, UnitCache[unitId]);
                end
            end
        end
        TriggerClientEvent("SonoranCAD::mini:CallSync", -1, CallCache, EmergencyCache)
    end
end)

AddEventHandler("SonoranCAD::pushevents:DispatchNote", function(data)
    TriggerClientEvent("SonoranCAD::mini:NewNote", -1, data)
end)

RegisterServerEvent("SonoranCAD::mini:OpenMini")
AddEventHandler("SonoranCAD::mini:OpenMini", function ()
    local ident = exports["sonorancad"]:GetUnitByPlayerId(source)
    if ident == nil then TriggerClientEvent("SonoranCAD::mini:OpenMini:Return", source, false) end
    if ident.data == nil then TriggerClientEvent("SonoranCAD::mini:OpenMini:Return", source, false) end
    if ident.data.apiIds[1] == nil then TriggerClientEvent("SonoranCAD::mini:OpenMini:Return", source, false) end
    TriggerClientEvent("SonoranCAD::mini:OpenMini:Return", source, true, ident.id)
end)

exports["sonorancad"]:registerApiType("ATTACH_UNIT", "emergency")
RegisterServerEvent("SonoranCAD::mini:AttachToCall")
AddEventHandler("SonoranCAD::mini:AttachToCall", function(callId)
    --Debug Only
    --print("cl_main -> sv_main: SonoranCAD::mini:AttachToCall")
    local ident = exports["sonorancad"]:GetUnitByPlayerId(source)
    if ident ~= nil then
        local data = {callId = callId, units = {ident.data.apiIds[1]}, serverId = 1}
        exports["sonorancad"]:performApiRequest({data}, "ATTACH_UNIT", function(res)
            print("Attach OK: " .. tostring(res))
        end)
    else
        print("Unable to attach... if api id is set properly, try relogging into cad.")
    end
end)

exports["sonorancad"]:registerApiType("ADD_CALL_NOTE", "emergency")
exports["sonorancad"]:registerApiType("DETACH_UNIT", "emergency")
RegisterServerEvent("SonoranCAD::mini:DetachFromCall")
AddEventHandler("SonoranCAD::mini:DetachFromCall", function(callId)
    --Debug Only
    --print("cl_main -> sv_main: SonoranCAD::mini:DetachFromCall")
    local ident = exports["sonorancad"]:GetUnitByPlayerId(source)
    if ident ~= nil then
        local data = {callId = callId, units = {ident.data.apiIds[1]}, serverId = 1}
        exports["sonorancad"]:performApiRequest({data}, "DETACH_UNIT", function(res)
            print("Detach OK: " .. tostring(res))
            data = {callId = callId, serverId = 1, note = ident.data.unitNum .. " detached."}
            exports["sonorancad"]:performApiRequest({data}, "ADD_CALL_NOTE", function(res)
                print("Note Add OK: " .. tostring(res))
            end)
        end)
    else
        print("Unable to detach... if api id is set properly, try relogging into cad.")
    end
end)