<template>
    <breeze-authenticated-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        You're logged in!
                    </div>
                </div>
            </div>
        </div>
        <div id="blocklyDiv">
        <blocklyblocks />
        </div>
        <xml id="blocklyDefault" style="display: none">
        </xml>

    </breeze-authenticated-layout >
    
</template>

<script>
    import BreezeAuthenticatedLayout from '@/Layouts/Authenticated'
    import blocklyblocks from '@/Components/Blocklyblocks';
    import Blockly from 'blockly';
    export default {
        components: {
            BreezeAuthenticatedLayout,
            blocklyblocks
        },
    }
    let workspace = Blockly.inject('blocklyDiv',{toolbox: document.getElementById('toolbox')});
    let defaultBlocks = document.getElementById('blocklyDefault');
</script>
