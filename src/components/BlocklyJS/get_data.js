import * as Blockly from 'blockly/core';
import "blockly/javascript";
import axios from 'axios';

Blockly.defineBlocksWithJsonArray([
    {
        "type": "get_data",
        "message0": "get device %1 %2",
        "args0": [
            {
                "type": "input_value",
                "name": "device",
                "check": ["String"]
            },
            {
                "type": "input_value",
                "name": "mode",
                "check": ["String"]
            },
        ],
        "message1": "Then, do %1",
        "args1": [
            {
                "type": "input_statement",
                "name": "DO0"
            },
        ],
        "previousStatement":true,
        "nextStatement": true,
        "inputsInline": true,
        
        
        "colour": '#0ddb69',
        "tooltip": "",
        "helpUrl": "",
        
    },
]);
Blockly.JavaScript['get_data'] = function(block) {
    var device = Blockly.JavaScript.statementToCode(block, 'device');
    var mode = Blockly.JavaScript.statementToCode(block, 'mode');
    
    var code = "";
    code = `change_mode(${device},${mode});\n`+
    `get_data(${device},${mode});\n`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};

function get_data(device)
    {
    axios.get(build_link(device))
    .then(function (response) {
        // handle success
        return response.data.status;
      })
    }
function change_mode(device,mode)
{
    axios.patch(build_link(device), {mode:mode, status: false });
}    
function build_link(device_id="")
{
    let user=localStorage.getItem("user_id");
    let room=localStorage.getItem("room_id");
    return "https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/"+user+"/rooms/"+room+"/devices/"+device_id+".json";
}
export
{
    change_mode,
    get_data 
}