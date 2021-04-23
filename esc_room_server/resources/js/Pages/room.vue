<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Room - {{room[0].name}}
            </h2>
        </template>

        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="grid md:grid-cols-12 gap-3 md:bg-purple-300 md:p-5 md:py-20">
                    <div class="col-span-full md:col-span-4">
                    <h1 class=" inline text-xl text-white bg-purple-800 p-2 capitalize">Management Room</h1>
                    <div class="flex flex-col items-start justify-center bg-purple-100 p-6" >
                    <inertia-link class="w-30 flex items-center justify-center rounded-md bg-black text-white" :href="'run/'+room[0].id">Start</inertia-link>
                    </div>
                    </div>
                    <div class="col-span-full md:col-span-8">
                    <h1 class=" inline text-xl text-white bg-purple-800 p-2 capitalize">Devices</h1>
                    <div class="flex flex-col items-start justify-center bg-purple-100 p-6" >
                        <h2> Assign devices to room</h2>
                        <select name="add-device">
                        </select>

                    </div>
                    </div>
                    <div class="col-span-full md:col-span-8">
                    <h1 class=" inline text-xl text-white bg-purple-800 p-2 capitalize">Cameras</h1>
                    <div class="flex flex-col items-start justify-center bg-purple-100 p-6 ">
                        <h2>Assign cameras to room</h2>
                        <select name="add-device">
                        </select>
                    </div>
                    Enter into lobby:
                    <inertia-link :href="'/lobby/'+room.id">Enter into lobby <BIconArrowRightSquareFill class="bg-green-500"/></inertia-link>

                </div>
        </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import {BIconArrowRightSquareFill} from 'bootstrap-icons-vue';

    export default {
        components: {
            AppLayout,
            Welcome,
            BIconArrowRightSquareFill
            
        },
        props: {
            room:{ 
                type:Array,
                required: true
            }
        }
    }
</script>