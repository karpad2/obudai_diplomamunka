<template>
   <app-layout>
        
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Programs
            </h2>
        </template>
        <jet-form-section @submitted="onPrograms">
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    
            
            <div class="col-span-6 sm:col-span-4">
                <jet-label for="program_name" value="Program Name" />
                <jet-input id="program_name" type="text" class="mt-1 block w-full" v-model="form.program_name" ref="program_name" autocomplete="program_name" />
                <jet-input-error :message="form.errors.current_program_name" class="mt-2" />
            </div>
            <div id="blocklyDiv" class="mt-1 block w-full" style="height: 480px;"></div>
            <block_vue />
            <textarea id="program_javascript" v-model="form.program_javascript" name="program_javascript" style="display:none"></textarea>
            <textarea id="program_xml" v-model="form.program_xml" name="program_xml" style="display:none"></textarea>
       
                   
            </div>
            <jet-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Save
            </jet-button>
            </div>
        </div>
        </jet-form-section>
       
       
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
   // 
    import Blockly from 'blockly';
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
        {
            return {
                form: this.$inertia.form(
                    {
                        program_name:'',
                        program_xml:'',
                        program_javascript:''
                    }
                )
            }
        },
        methods:{
            onPrograms()
            {
                this.form.put(route('programs.update'),{
                    errorBag: 'onPrograms',
                    preserveScroll:true,
                    onSuccess:() =>this.form.reset(),
                    
                })
            }
        },
        mounted()
        {
        Blockly.setLocale(En);
        let Workspace = Blockly.inject('blocklyDiv',
        {
         media: '/media/',
         toolbox: document.getElementById('toolbox')});
         }
        



    }

  /*   let demoWorkspace = Blockly.inject('blocklyDiv',
        {media: '../../media/',
         toolbox: document.getElementById('toolbox')});*/

         /* 
         
         <div id="blocklyDiv" class="content"></div>
<textarea id="content_xml" class="content" wrap="off"  style="display: none"></textarea>
                    <xml id="toolbox" style="display: none">
                    <block_vue />
                    </xml>
         
         */
</script>
