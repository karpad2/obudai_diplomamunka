#include "config.h"
#include <FirebaseESP32.h>
#include <Arduino.h>

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;


void firebase_begin()
{   Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
    
    String firebase_host="";
    String apikey="";
    String useremail="";
    String userpass="";
    String database_url="";


    firebase_host=doc["firebase_host"].as<String>();
    apikey=doc["apikey"].as<String>();
    useremail=doc["useremail"].as<String>();
    userpass=doc["userpass"].as<String>(); 
    database_url=doc["database_url"].as<String>(); 


    config.host = firebase_host.c_str();
    config.api_key = apikey.c_str();
    config.database_url = database_url.c_str();
    auth.user.email = useremail.c_str();
    auth.user.password = userpass.c_str();
    

    Firebase.begin(&config, &auth);
    fbdo.setResponseSize(8192);
    Firebase.enableClassicRequest(fbdo, true);
    Firebase.setMaxRetry(fbdo, 5);
    Firebase.setMaxErrorQueue(fbdo, 30);
    Firebase.reconnectWiFi(true);
    //Firebase.setSystemTime();
    
    //Firebase.setReadWriteRules(fbdo, base_path.c_str(), DATABASE_SECRET);
}