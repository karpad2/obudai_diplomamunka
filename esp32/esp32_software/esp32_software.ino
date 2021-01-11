#include "config.h"
#include "server_config.h"
#include "networking.h"



void setup() {
  pinouts();
  Serial.begin(115200);
  server_setup();
}

void loop(void) {
  server.handleClient();
}
