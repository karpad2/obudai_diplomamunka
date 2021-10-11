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
Blockly.JavaScript['send_data'] = function(block) {
    var device = Blockly.JavaScript.statementToCode(block, 'device');
    var mode = Blockly.JavaScript.statementToCode(block, 'mode');
    var value = Blockly.JavaScript.statementToCode(block, 'value');
    var code = `set_data(${device},${mode},${value});\n`;
    return  [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};
function set_data(device,mode,value)
    {
    const res = axios.patch(build_link(device), {mode:mode, status: value });
    }
function build_link(device_id="")
{
    let user=localStorage.getItem("user_id");
    let room=localStorage.getItem("room_id");
    return "https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/"+user+"/rooms/"+room+"/devices/"+device_id+".json";
}

export {
    set_data
}  
