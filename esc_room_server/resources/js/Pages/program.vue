<template>
   <app-layout>
    <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Programming Interface {{program[0].name}}
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    
            
            <div class="col-span-6 sm:col-span-4">
            <jet-label for="program_name" value="Program Name" />
            <jet-input id="program_name" type="text" class="mt-1 block w-full" v-model="program[0].name" ref="program_name" autocomplete="program_name" />
            <jet-input-error :message="program_name" class="mt-2" />
            </div>
            <div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px;"></div>
            <block_vue />
            <xml id="blocklyDefault" v-model="program[0].xml_block" style="display: none"></xml>
            <textarea id="program_javascript" v-model="program[0].javascript_block" name="program_javascript" style="display:none"></textarea>
            <textarea id="program_xml" v-model="program[0].xml_block" name="program_xml" style="display:none"></textarea>
            </div>
            <jet-button v-on:click="save">
                Save
            </jet-button>
            </div>
        </div>
       </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import block_vue from '@/Components/block_vue';
    import JetActionMessage from '@/Jetstream/ActionMessage'
    import JetButton from '@/Jetstream/Button'
    import JetFormSection from '@/Jetstream/FormSection'
    import JetInput from '@/Jetstream/Input'
    import JetInputError from '@/Jetstream/InputError'
    import JetLabel from '@/Jetstream/Label'
    import axios from 'axios';
    import Blockly, { Workspace } from 'blockly';
    import * as En from 'blockly/msg/en';
    import BlocklyJS from 'blockly/javascript';

    export default {
        components: {
            AppLayout,
            block_vue,
            Welcome,
            JetButton,
            JetInput,
            JetInputError,
            JetLabel,
            Blockly
        },
        data()
        {  return {
            a_program_name:'',
            a_program_xml:'',
            a_program_javascript:''};
        },
        props: {
            program:{ 
                type:Array,
                required: true
            },
        },
    methods:{
            myUpdateFunction(event) {},
            save(){ 
                    axios.post("/api/update-program/"+this.program[0].id,{
                    name:this.program[0].name,
                    xml_block:this.program[0].xml_block,
                    javascript_block:this.program[0].javascript_block});
                    },
             auto_compile()
             {
                console.log("im here")
                this.program[0].javascript_block=BlocklyJS.workspaceToCode(Workspace);
                this.program[0].xml_block=Blockly.Xml.workspaceToCode(Workspace);  
             }       
            },
mounted (){
    let defaultBlocks = document.getElementById('blocklyDefault');
        Blockly.setLocale(En);
        let Workspace = Blockly.inject('blocklyDiv',{
         media: '/media/',
         toolbox: document.getElementById('toolbox')});
        Workspace.addChangeListener(()=>
        {
            this.auto_compile()
        });
    
    Blockly.Xml.domToWorkspace(defaultBlocks, Workspace);       
    }
    }
</script>
