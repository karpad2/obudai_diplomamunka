//
// Created by karpad2 on 1/9/2021.
//

#include "SPIFFS.h"
#ifndef ESP32_FILESYSTEM_H
#define ESP32_FILESYSTEM_H

void fs_setup()
{
    if(!SPIFFS.begin(true)){
        Serial.println("An Error has occurred while mounting SPIFFS");
        return;
    }
}

#endif //ESP32_FILESYSTEM_H
