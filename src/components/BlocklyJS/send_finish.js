import * as Blockly from 'blockly/core';
import "blockly/javascript";

Blockly.defineBlocksWithJsonArray([
    {
        "type": "send_finish",
        "message0": "send finish",
        
            
       
        
        "previousStatement": true,
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
Blockly.JavaScript['send_finish'] = function(block) {
   
    var code = `send_finish();\n`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};

function build_link( device_id="")
{
    let user=localStorage.getItem("user_id");
    let room=localStorage.getItem("room_id");
    return "https://escaperoom-b4ae9-default-rtdb.europe-west1.firebasedatabase.app/users/"+user+"/rooms/"+room+"/devices/"+device_id+".json";
}
