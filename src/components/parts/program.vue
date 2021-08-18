<template>
  <app-layout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Programming Interface {{ program[0].name }}
      </h2>
    </template>
    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
          <div class="col-span-6 sm:col-span-4">
            <jet-label for="program_name" value="Program Name" />
            <jet-input
              id="program_name"
              type="text"
              class="mt-1 block w-full"
              v-model="program[0].name"
              ref="program_name"
              autocomplete="program_name"
              v-on:change="save"
            />
            <jet-input-error :message="program_name" class="mt-2" />
          </div>
          <div
            id="blocklyDiv"
            class="mt-1 block w-full"
            style="height: 480px"
          ></div>
          <blockvue :devices="devices" />
          <textarea
            id="program_javascript"
            v-model="program[0].javascript_block"
            class="mt-1 block w-full"
            style="display: block"
            name="program_javascript"
          ></textarea>
          <textarea
            id="blocklyDefault"
            v-model="program[0].xml_block"
            name="program_xml"
            class="mt-1 block w-full"
            style="display: none"
          ></textarea>
        </div>
      </div>
    </div>
  </app-layout>
</template>

<script>
import AppLayout from "@/Layouts/AppLayout";
import Welcome from "@/Jetstream/Welcome";
import blockvue from "@/Components/blockvue";
import JetActionMessage from "@/Jetstream/ActionMessage";
import JetButton from "@/Jetstream/Button";
import JetFormSection from "@/Jetstream/FormSection";
import JetInput from "@/Jetstream/Input";
import JetInputError from "@/Jetstream/InputError";
import JetLabel from "@/Jetstream/Label";
import axios from "axios";
import * as Blockly from "blockly";
import * as En from "blockly/msg/en";
import BlocklyJS from "blockly/javascript";

export default {
  components: {
    AppLayout,
    blockvue,
    Welcome,
    JetButton,
    JetInput,
    JetInputError,
    JetLabel,
    Blockly,
  },
  data() {
    return {
      a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
    };
  },
  props: {
    program: {
      type: Array,
      required: true,
    },
    devices: {
      type: Array,
      required: true,
    },
  },
  methods: {
    myUpdateFunction(event) {},
    save() {
      if (this.program[0].javascript_block != "") {
        axios.post("/api/update-program/" + this.program[0].id, {
          name: this.program[0].name,
          xml_block: this.program[0].xml_block,
          javascript_block: this.program[0].javascript_block,
        });
      }
    },
    auto_compile(workspace) {
      console.log("im here");
      this.program[0].javascript_block = BlocklyJS.workspaceToCode(workspace);
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
        },
      };
      Blockly.Blocks["send_finish"] = {
        init: function () {
          this.appendValueInput("VALUE")
            .setCheck("String")
            .appendField("Send Finish");
          //this.setOutput(true, 'Number');
          this.setColour(140);
          this.setPreviousStatement(true);
          this.setTooltip("This module will finish the program.");
          this.setHelpUrl(
            "http://www.w3schools.com/jsref/jsref_length_string.asp"
          );
        },
      };
      (Blockly.Blocks["get_data"] = {
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
        },
      });
      

      
        auto_setup_js();
      {
        /*
        Blockly.JavaScript['play_sound'] = function(block) {
  let value = '\'' + block.getFieldValue('VALUE') + '\'';
  return 'MusicMaker.queueSound(' + value + ');\n';
};
        */

        BlocklyJS["send_data"] = function (block) {
          // Search the text for a substring.
          var operator =
            block.getFieldValue("END") == "FIRST" ? "indexOf" : "lastIndexOf";
          var subString =
            Blockly.JavaScript.valueToCode(
              block,
              "FIND",
              Blockly.JavaScript.ORDER_NONE
            ) || "''";
          var text =
            Blockly.JavaScript.valueToCode(
              block,
              "VALUE",
              Blockly.JavaScript.ORDER_MEMBER
            ) || "''";
          var code = "send_data" + "." + operator + "(" + subString + ")";
          return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
        };

        BlocklyJS["get_data"] = function (block) {
          // Search the text for a substring.
          var operator =
            block.getFieldValue("END") == "FIRST" ? "indexOf" : "lastIndexOf";
          var subString =
            Blockly.JavaScript.valueToCode(
              block,
              "FIND",
              Blockly.JavaScript.ORDER_NONE
            ) || "''";
          var text =
            Blockly.JavaScript.valueToCode(
              block,
              "VALUE",
              Blockly.JavaScript.ORDER_MEMBER
            ) || "''";
          var code = "send_data" + "." + operator + "(" + subString + ")";
          return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
        };

        BlocklyJS["send_finish"] = function (block) {
          // Search the text for a substring.
          var code = "send_finish()";
          return [code, Blockly.JavaScript.ORDER_FUNCTION_CALL];
        };
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
};
</script>
<style>
@import url("https://fonts.googleapis.com/icon?family=Material+Icons");

.app-container {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  overflow: visible;
  background-color: #0097a7;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.14), 0 4px 8px rgba(0, 0, 0, 0.28);
  margin: 10px;
}

.blocklyScrollbarHandle {
  display: none;
}

.main {
  position: absolute;
  top: 8px;
  bottom: 8px;
}

.blockly-panel {
  left: 8px;
  right: 298px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.37);
}

.output-panel {
  right: 8px;
  width: 282px;
  background-color: white;
  overflow: scroll;
  padding: 8px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.37);
}

.dropdown-bar {
  display: block;
  font-family: sans-serif;
  font-size: 16px;
  width: 200px;
  margin-left: auto;
  margin-right: auto;
}

#languageDropdown {
  border: 0;
  background-color: transparent;
  font-size: 16px;
  outline: none;
}

#im-just-an-underline {
  border-bottom: 1px solid;
  display: inline;
  padding-right: 5px;
}

.POps {
  height: 1px;
  border: 0;
  background-color: rgba(0, 0, 0, 0.2);
}

.play-button {
  position: absolute;
  bottom: 24px;
  right: 24px;
  border-radius: 100%;
  color: white;
  width: 56px;
  height: 56px;
  line-height: 56px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.37);
  transition: box-shadow 0.3s ease-in-out;
  text-align: center;
  font-weight: 500;
  background-color: #0097a7;
  cursor: pointer;
}

.play-button:hover {
  box-shadow: 0 2px 2px rgba(0, 0, 0, 0.2), 0 6px 10px rgba(0, 0, 0, 0.3);
  transition: box-shadow 0.3s ease-in-out;
}

.but-not-that-pretty {
  border: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
}
</style>