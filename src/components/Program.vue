<template>
<div class="center">
<h2>Programs ~ {{program.program.name}}</h2>

<div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px"></div>

 <textarea id="program_javascript" v-model="program[0].javascript_block" class="mt-1 block w-full" style="display: block" name="program_javascript" ></textarea>
 <textarea id="blocklyDefault" v-model="program[0].xml_block" name="program_xml" class="mt-1 block w-full" style="display: none"></textarea>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
</div>
</template>
<script>
import {Blockly} from "blockly";
import * as En from "blockly/msg/en";

import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

export default {
    name: 'Programs',
    data: () => ({
      showDialog: false,
	    a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
      camera:{},
            showDeleteDialog:false
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
      }
        console.log("WELP");
      },
      delete_program()
                {
                console.log("Delete process");
                    const userId = FirebaseAuth.currentUser.uid;
                    let b=[];
                    let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.pid}`);
                    set(_ref,null);
                    this.$route.router.go(-1); 

                },
                onCancel () {
                        //this.value = 'Disagreed'
                    },
                achange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/camera_url`);
                        set(_ref,this.camera.camera_url);
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/camera/${this.$route.params.did}/camera_name`);
                        set(_ref,this.device.camera_name);
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

    console.log(this.$route.params);
        //localStorage.setItem('device',JSON.stringify(null));
        const userId = FirebaseAuth.currentUser.uid;
        const devId = this.$route.params.pid;
        const room_id=this.$route.params.rid;
        

        onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/programs/${devId}`),(sn)=>{
       if(sn.exists()) 
       {this.camera=sn.val();
        //this.select=this.device.mode;
       }
        });

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
