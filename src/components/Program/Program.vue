<template>
<div class="center">
<h2>Programs</h2>

<div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px"></div>

 <textarea id="program_javascript" v-model="program[0].javascript_block" class="mt-1 block w-full" style="display: block" name="program_javascript" ></textarea>
          <textarea id="blocklyDefault" v-model="program[0].xml_block" name="program_xml"
		   class="mt-1 block w-full" style="display: none"></textarea>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
</div>
</template>
<script>
import * as Blockly from "blockly";
import * as En from "blockly/msg/en";
import BlocklyJS from "blockly/javascript";

export default {
    name: 'Programs',
    data: () => ({
      showDialog: false,
	  a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
    })
  }





</script>
