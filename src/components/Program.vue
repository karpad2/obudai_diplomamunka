<template>
<div class="center">
<h2>Program ~ {{program.program_name}}</h2>

<div id="blocklyDiv"  style="height: 480px; width: 640px"></div>

 <textarea id="program_javascript" v-model="program.javascript"  style="display: block" name="program_javascript" ></textarea>
 <textarea id="blocklyDefault" v-model="program.xml" name="program_xml" style="display: none"></textarea>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>

<md-dialog-confirm
      :md-active.sync="showDeleteDialog"
      md-title="Delete this program?"
      md-content="Your program will be deleted."
      md-confirm-text="Continue"
      md-cancel-text="Cancel"
      @md-cancel="onCancel()"
      @md-confirm="delete_program()" />

</div>
</template>
<script>
import Blockly from 'blockly';
import * as En from "blockly/msg/en";
import 'blockly/javascript';
import 'blockly/blocks';  
//import {media} from "blockly/media";
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";

export default {
    name: 'Programs',
    data: () => ({
      program:{},
      showDialog: false,
	    a_program_name: "",
      a_program_xml: "",
      a_program_javascript: "",
      camera:{},
      showDeleteDialog:false
    }),
    comments:{
      Blockly
    },
     methods: {
    myUpdateFunction(event) {},
    save() {
      if (this.program[0].javascript != "") {
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
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.cid}/program_xml`);
                        set(_ref,this.program.xml);

                        _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.cid}/program_javascript`);
                        set(_ref,this.program.javascript);
                       // _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/devices/${this.$route.params.cid}/status`);
                       // set(_ref,false);
                    },
                    namechange()
                    {
                        const userId = FirebaseAuth.currentUser.uid;
                        //console.log(this.device.mode);
                        let _ref= ref(FireDb, `/users/${userId}/rooms/${this.$route.params.rid}/programs/${this.$route.params.did}/program_name`);
                        set(_ref,this.program.program_name);
                    },
    
    auto_compile(workspace) {
      console.log("im here");
      this.program.javascript = Blockly.Javascript.workspaceToCode(workspace);
      let xml = Blockly.Xml.workspaceToDom(workspace);
      console.log(xml);
      if (this.program.javascript != "") {
        this.program.xml = Blockly.Xml.domToText(xml);
        this.achange();
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
       {this.program=sn.val();
        //this.select=this.device.mode;
       }
        });

    Blockly.setLocale(En);
    //let blocklyDefault = document.getElementById("blocklyDefault");
    let Workspace = Blockly.inject("blocklyDiv", {
      toolbox: document.getElementById("toolbox"),
      scrollbar: false,
    });
    //media: "/media/",
    let workspace_default = Blockly.Xml.textToDom(this.program.xml);
    Blockly.Xml.appendDomToWorkspace(workspace_default, Workspace);

    Workspace.addChangeListener(() => {
      this.auto_compile(Workspace);
    });
    this.auto_setup();
    this.auto_setup_js();
  },
  }





</script>
