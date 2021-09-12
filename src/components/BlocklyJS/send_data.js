import * as Blockly from 'blockly/core';
import "blockly/javascript";

Blockly.defineBlocksWithJsonArray([
    {
        "type": "send_data",
        "message0": "set device %1 %2 %3",
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
            {
                "type": "input_value",
                "name": "value",
                "check": ["String"]
            }
        ],
        "inputsInline": true,
       
        "colour": '#0ddb69',
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
    var code = `set_data(${device},${mode},${value});`;
    return  [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};