import * as Blockly from 'blockly/core';
import "blockly/javascript";
import axios from 'axios';


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
