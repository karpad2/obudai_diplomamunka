import * as Blockly from 'blockly/core';
import "blockly/javascript";

//device_modifier
Blockly.defineBlocksWithJsonArray([
    {
        "type": "devices",
        "message0": "%1",
        "args0": [
          {
            "type": "field_dropdown",
            "name": "LISTS",
            "options": [
              ["%{BKY_LOGIC_BOOLEAN_TRUE}", "TRUE"],
              ["%{BKY_LOGIC_BOOLEAN_FALSE}", "FALSE"]
            ]
          }
        ],
        "previousStatement": true,
        "nextStatement": true,
        "output": "String",
        "style": "lists_blocks",
        "tooltip": "%{BKY_LOGIC_BOOLEAN_TOOLTIP}",
        "helpUrl": "%{BKY_LOGIC_BOOLEAN_HELPURL}"
      },
]);


Blockly.JavaScript['devices'] = function(block) {
    var argumentOld = Blockly.JavaScript.statementToCode(block, 'as_oldName');
    var argumentNew = Blockly.JavaScript.statementToCode(block, 'as_newName');
    var code = argumentOld + ' as ' + argumentNew;
    return code;
};
