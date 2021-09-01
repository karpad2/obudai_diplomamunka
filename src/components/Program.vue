<template>
<div class="center">
<h2>Programs</h2>

<div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px"></div>

 <textarea id="program_javascript" v-model="program[0].javascript_block" class="mt-1 block w-full" style="display: block" name="program_javascript" ></textarea>
 <textarea id="blocklyDefault" v-model="program[0].xml_block" name="program_xml" class="mt-1 block w-full" style="display: none"></textarea>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
</div>
</template>
<script>
import {Blockly} from "blockly";
import * as En from "blockly/msg/en";


export default {
    name: 'Programs',
    data: () => ({
      showDialog: false,
	    a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
    }),
     methods: {
    myUpdateFunction(event) {},
    save() {
      if (this.program[0].javascript_block != "") {
        /*axios.post("/api/update-program/" + this.program[0].id, {
          name: this.program[0].name,
          xml_block: this.program[0].xml_block,
          javascript_block: this.program[0].javascript_block,
        });*/
        console.log("WELP");
      }
    },
    auto_compile(workspace) {
      console.log("im here");
      this.program[0].javascript_block = Blockly.Javascript.workspaceToCode(workspace);
      let xml = Blockly.Xml.workspaceToDom(workspace);
      console.log(xml);
      if (this.program[0].javascript_block != "") {
        this.program[0].xml_block = Blockly.Xml.domToText(xml);
        this.save();
      }
    },
    auto_setup() {
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
          this.setHelpUrl(
            "http://www.w3schools.com/jsref/jsref_length_string.asp"
          );
        }
      }
     
      
      
    },
  },
  mounted() {


    Blockly.setLocale(En);
    let blocklyDefault = document.getElementById("blocklyDefault");
    let Workspace = Blockly.inject("blocklyDiv", {
      media: "/media/",
      toolbox: document.getElementById("toolbox"),
      scrollbar: false,
    });
    let workspace_default = Blockly.Xml.textToDom(this.program[0].xml_block);
    Blockly.Xml.appendDomToWorkspace(workspace_default, Workspace);

    Workspace.addChangeListener(() => {
      this.auto_compile(Workspace);
    });
    this.auto_setup();
    this.auto_setup_js();
  },
  }





</script>
