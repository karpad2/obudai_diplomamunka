<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Run
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg col-span-full md:col-span-4">
                   
                    <p>Status:{{status}}/{{room_max}}</p>
                    <div>
                    <button>Stop</button>
                    </div>
                    <div>
                    <button>Unlock doors</button>
                    </div>
                    <div class="bg-indigo-300 ...">
                     <img class="object-contain h-48 w-full" :src="getImgUrl(pic)" v-bind:alt="pic">
                    </div>
                     


                </div>
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
            Blockly
        },
        props: {
            run:{ 
                type:Array,
                required: true
            },
            cameras:{
                type:Array,
                required: true
            }
        }
    }
</script>