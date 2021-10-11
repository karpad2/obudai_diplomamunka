import * as Blockly from 'blockly/core';
import "blockly/javascript";

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
    
    var code = `get_data(${device},${mode});\n`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};