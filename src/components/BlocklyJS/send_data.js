import * as Blockly from 'blockly/core';
import "blockly/javascript";
import axios from 'axios';
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

Blockly.defineBlocksWithJsonArray([
    {
        "type": "send_data",
        "message0": "set device %1, mode: %2, status: %3",
        "args0": [
            {
                "type": "field_variable",
                "name": "device",
                "check": ["String"]
            },
            {
                "type": "field_dropdown",
                "name": "mode",
                "variableTypes": [""],
                "options": [
                    ["Relay", "relay"],
                    ["RFID reader", "rfid"],
                    ["Input", "input"],
                    ["OLED Display", "oled"],
                ]
            },
            {
                "type": "input_value",
                "name": "value",
                "check": ["String"]
            }
        ],
        "inputsInline": true,
        "previousStatement": true,
        "nextStatement": true,
        "colour": 160,
        "tooltip": "",
        "helpUrl": "",
        
    },
]);//AS-Modifier

/*
 "output": '',
  
Blockly.Extensions.register('assExtensions', function(){
    this.setOnChange(function (changeEvent) {
        var parent = this.getSurroundParent();
        if(parent != null){
            if(parent.toDevString().includes('select_from') || parent.toDevString().includes('all_join')){
                this.getInput('as_oldName').setCheck("TABLE");
            }
            else{
                this.getInput('as_oldName').setCheck(["freeinput", "aggregate_min", "aggregate_max", "aggregate_avg", "aggregate_count", "aggregate_sum", "CONDITIONCHOOSER"]);
            }
        }
    })
});*/

