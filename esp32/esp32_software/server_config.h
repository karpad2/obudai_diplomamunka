//
// Created by karpad2 on 1/9/2021.
//

#ifndef ESP32_SERVER_CONFIG_H
#define ESP32_SERVER_CONFIG_H
#include "config.h"
#include <WebServer.h>

WebServer server(PORT);


void handleRoot() {
    digitalWrite(led, 1);
    server.send(200, "text/plain", "hello from esp8266!");
    digitalWrite(led, 0);
}

void handleNotFound() {
    digitalWrite(led, 1);
    String message = "File Not Found\n\n";
    message += "URI: ";
    message += server.uri();
    message += "\nMethod: ";
    message += (server.method() == HTTP_GET) ? "GET" : "POST";
    message += "\nArguments: ";
    message += server.args();
    message += "\n";
    for (uint8_t i = 0; i < server.args(); i++) {
        message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
    }
    server.send(404, "text/plain", message);
    digitalWrite(led, 0);
}




void server_setup()
{
    server.on("/", handleRoot);

    server.on("/inline", []() {
        server.send(200, "text/plain", "this works as well");
    });

    server.onNotFound(handleNotFound);

    server.begin();
    Serial.println("HTTP server started");
}


#endif //ESP32_SERVER_CONFIG_H
