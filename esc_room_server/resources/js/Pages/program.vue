<template>
   <app-layout>
    <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Programming Interface {{a_program_name}}
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    
            
            <div class="col-span-6 sm:col-span-4">
            <jet-label for="program_name" value="Program Name" />
            <jet-input id="program_name" type="text" class="mt-1 block w-full" v-model="a_program_name" ref="program_name" autocomplete="program_name" />
            <jet-input-error :message="program_name" class="mt-2" />
            </div>
            <div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px;"></div>
            <block_vue />
            <xml id="blocklyDefault" v-model="a_program_xml" style="display: none"></xml>
            <textarea id="program_javascript" v-model="program_javascript" name="program_javascript" style="display:none"></textarea>
            <textarea id="program_xml" v-model="program_xml" name="program_xml" style="display:none"></textarea>
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
    import 'blockly/javascript';

    export default {
        components: {
            AppLayout,
            block_vue,
            Welcome,
            JetButton,
            JetInput,
            JetInputError,
            JetLabel
        },
        data()
        {  return{
            a_program_name:'',
            a_program_xml:'',
            a_program_javascript:''}
        },
        props: {
            program:{ 
                type:Array,
                required: true
            },
        },
    methods:{
            myUpdateFunction(event) {
                a_program_javascript=Blockly.Javascript.workspaceToCode(Workspace);
                a_program_xml=Blockly.Xml.workspaceToCode(Workspace);       
            },
            save(){ 
                    axios.post("update-programs/save/"+rooms[0].id,{program_name:this.a_program_name,program_xml:this.a_program_xml,program_javascript:this.a_program_javascript});
                    }
            },
mounted: ()=>{
    let defaultBlocks = document.getElementById('blocklyDefault');
        Blockly.setLocale(En);
        let Workspace = Blockly.inject('blocklyDiv',{
         media: '/media/',
         toolbox: document.getElementById('toolbox')});
        Workspace.addChangeListener(myUpdateFunction);
    
    if(this.program =={})
    {

    }
    else
    {
        a_program_xml=this.program[0].program_xml;
        a_program_javascript=this.program[0].program_javascript;
        Blockly.Xml.domToWorkspace(defaultBlocks, Workspace);

    }
        
    }
    }
</script>
