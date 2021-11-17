local jukebox_default_tracks = MusicManager.jukebox_default_tracks
function MusicManager:jukebox_default_tracks()
    local trax = jukebox_default_tracks(self)
    
    trax.heist_hardware_store_wrapper_name = "pd2c_hardwareStore_ost"
    
    return trax
end