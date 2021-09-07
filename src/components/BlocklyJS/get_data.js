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
        "inputsInline": true,
        "output": "String",
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
Blockly.JavaScript['get_data'] = function(block) {
    var device = Blockly.JavaScript.statementToCode(block, 'device');
    var mode = Blockly.JavaScript.statementToCode(block, 'mode');
    
    var code = `get_data(${device},${mode});`;
    return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
};

/*
Blockly.JavaScript['controls_if'] = function(block) {
  // If/elseif/else condition.
  var n = 0;
  var code = '', branchCode, conditionCode;
  if (Blockly.JavaScript.STATEMENT_PREFIX) {
    // Automatic prefix insertion is switched off for this block.  Add manually.
    code += Blockly.JavaScript.injectId(Blockly.JavaScript.STATEMENT_PREFIX,
        block);
  }
  do {
    conditionCode = Blockly.JavaScript.valueToCode(block, 'IF' + n,
        Blockly.JavaScript.ORDER_NONE) || 'false';
    branchCode = Blockly.JavaScript.statementToCode(block, 'DO' + n);
    if (Blockly.JavaScript.STATEMENT_SUFFIX) {
      branchCode = Blockly.JavaScript.prefixLines(
          Blockly.JavaScript.injectId(Blockly.JavaScript.STATEMENT_SUFFIX,
          block), Blockly.JavaScript.INDENT) + branchCode;
    }
    code += (n > 0 ? ' else ' : '') +
        'if (' + conditionCode + ') {\n' + branchCode + '}';
    ++n;
  } while (block.getInput('IF' + n));

  if (block.getInput('ELSE') || Blockly.JavaScript.STATEMENT_SUFFIX) {
    branchCode = Blockly.JavaScript.statementToCode(block, 'ELSE');
    if (Blockly.JavaScript.STATEMENT_SUFFIX) {
      branchCode = Blockly.JavaScript.prefixLines(
          Blockly.JavaScript.injectId(Blockly.JavaScript.STATEMENT_SUFFIX,
          block), Blockly.JavaScript.INDENT) + branchCode;
    }
    code += ' else {\n' + branchCode + '}';
  }
  return code + '\n';
};

*/