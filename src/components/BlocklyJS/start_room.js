import * as Blockly from 'blockly/core';
import "blockly/javascript";

Blockly.defineBlocksWithJsonArray([
    {
        "type": "start_room",
        "message0": "Start Progress",
        "args0": [
            
            
        ],
        "previousStatement": true,
        "nextStatement": true,
        "colour": '#0ddb69',
        "tooltip": "",
        "helpUrl": "https://github.com/karpad2/obudai_diplomamunka/wiki/Start-Process",
        
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
Blockly.JavaScript['start_room'] = function(block) {
    var device = Blockly.JavaScript.statementToCode(block, 'device');
    

    
    var code = `start_room();`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};
