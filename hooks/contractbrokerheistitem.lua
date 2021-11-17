--[Basic hook made by MiamiCenter, and changed by Offyerrocker to get it working.
local orig_get_dlc_stuff = ContractBrokerHeistItem.get_dlc_name_and_color

function ContractBrokerHeistItem:get_dlc_name_and_color(job_tweak,...)
    local dlc_name = ""
    local dlc_color = Color(1, 0, 1)

    if job_tweak.dlc then
        if job_tweak.dlc == "custom_heist" then
            dlc_color = Color("00FF00")

            if SystemInfo:distribution() == Idstring("STEAM") then
                dlc_name = managers.localization:to_upper_text("Diplomamunka")
            end
            return dlc_name, dlc_color
        end
    end
    return orig_get_dlc_stuff(self,job_tweak,...)
end