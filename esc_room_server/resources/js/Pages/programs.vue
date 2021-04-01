<template>
   <app-layout>
        <jet-form-section @submitted="updatePrograms">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Programs
            </h2>
        </template>

        <template #form>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">

                    
                    <div id="blocklyDiv" class="content"></div>
                    <textarea id="content_xml" class="content" wrap="off"  style="display: none"></textarea>
                    <xml xmlns="https://developers.google.com/blockly/xml" id="toolbox" style="display: none">
                    <block_vue />
                    </xml>
                </div>
            </div>
        </div>
      </template>
    </jet-form-section>
   </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'

    import JetActionMessage from '@/Jetstream/ActionMessage'
    import JetButton from '@/Jetstream/Button'
    import JetFormSection from '@/Jetstream/FormSection'
    import JetInput from '@/Jetstream/Input'
    import JetInputError from '@/Jetstream/InputError'
    import JetLabel from '@/Jetstream/Label'


    import block_vue from '@/Components/block_vue';
    import Blockly from 'blockly';
    import 'blockly/javascript';

    export default {
        components: {
            JetActionMessage,
            JetButton,
            JetFormSection,
            JetInput,
            JetInputError,
            JetLabel,
            AppLayout,
            Welcome,
            block_vue
        },
        data() {
            return {
               /* form: this.$inertia.form({
                    current_password: '',
                    password: '',
                    password_confirmation: '',
                }),*/
            }
        },
    }

  /*   let demoWorkspace = Blockly.inject('blocklyDiv',
        {media: '../../media/',
         toolbox: document.getElementById('toolbox')});*/
</script>