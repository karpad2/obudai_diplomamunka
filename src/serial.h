#include "config.h"
#include <Arduino.h>
#include <ArduinoJSON.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>

#include <BLE2902.h>

BLEUUID  SERVICE_UUID((uint16_t)0xFFE0); // UART service UUID
BLEUUID CHARACTERISTIC_UUID ((uint16_t)0xFFE1);


//#include <BluetoothSerial.h>
 void setup_bluetooth();
//BluetoothSerial SerialBT;
class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string value = pCharacteristic->getValue();

      if (value.length() > 0) {
        Serial.println("*********");
        Serial.print("New value: ");
        for (int i = 0; i < value.length(); i++)
        {
          Serial.print(value[i]);
          
        }

        Serial.println();
        Serial.println("*********");

        pCharacteristic->setValue(value +"\n"); // must add seperator \n for it to register on BLE terminal
        pCharacteristic->notify();
      }
    }
};



void setup_serial()
{
  
  Serial.begin(USBPORT);
  Serial.println("");
  //SerialBT.begin("EscapeRoom-device");
  
  
  Serial.println("Setup started...");
  setup_bluetooth();
  Serial.println("The device started, now you can pair it with bluetooth!");
}

void setup_bluetooth()
{
  BLEDevice::init(bluetooth_name);
  BLEServer *pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                         CHARACTERISTIC_UUID,
                                         BLECharacteristic::PROPERTY_READ |
                                         BLECharacteristic::PROPERTY_WRITE |
                                         BLECharacteristic::PROPERTY_NOTIFY
                                       );

          pCharacteristic->setCallbacks(new MyCallbacks());
          
          pCharacteristic->addDescriptor(new BLE2902());

          pService->start();

          BLEAdvertising *pAdvertising = pServer->getAdvertising();
          pAdvertising->start();

}

void bluetooth_serial()
{
  /*if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {
    Serial.write(SerialBT.read());
  }*/
}