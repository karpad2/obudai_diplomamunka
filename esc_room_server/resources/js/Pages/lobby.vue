<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Lobby
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                
                <jet-label for="name" value="Name of room" />
                <jet-input aria-placeholder="Enter room name..." id="name" type="name" class="mt-1 block w-full" v-model="add_name" required placeholder="Default" autofocus />
                
                <LinkButton :href="'/run/'+room[0].id">Start</LinkButton>


            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import Blockly from 'blockly';
    import 'blockly/javascript';

    export default {
        components: {
            AppLayout,
            Welcome,
            Blockly,
        },
        props: {
            run:{ 
                type:Array,
                required: true
            }
        }
    }
</script>