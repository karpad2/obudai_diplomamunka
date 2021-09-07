import * as Blockly from 'blockly/core';
import * as En from "blockly/msg/en";
import BlocklyJavascript from "blockly/javascript";
import 'blockly/blocks';
import Blocks from "@/components/parts/Blocks";

const BlocklyJS= ()=>
{
    console.info("Blockly add blocks");
    Blockly.Blocks["send_data"] = {
        init: function () {
          this.appendValueInput("VALUE")
            .setCheck("String")
            .appendField("Send Data");
          this.appendValueInput("LIST")
            .setCheck("Array")
            .setAlign(Blockly.ALIGN_RIGHT)
            .appendField("in list");
          this.setColour(170);
          this.setTooltip("Send data to device");
          this.setPreviousStatement(true);
          this.setNextStatement(true);
        },
        Blockly.Javascript["send_data"] = {
          init: function () {
            this.appendValueInput("VALUE")
              .setCheck("String")
              .appendField("Send Data");
            this.appendValueInput("LIST")
              .setCheck("Array")
              .setAlign(Blockly.ALIGN_RIGHT)
              .appendField("in list");
            this.setColour(170);
            this.setTooltip("Send data to device");
            this.setPreviousStatement(true);
            this.setNextStatement(true);
          }
      }
    }
       
};

export {
    BlocklyJS
}