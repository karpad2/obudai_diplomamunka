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
                    <inertia-link class="w-30 flex items-center justify-center rounded-md bg-black text-white" :href="'/run/'+room[0].id">Start</inertia-link>
                    <inertia-link class="w-30 flex items-center justify-center rounded-md bg-black text-white" :href="'/create-program/'+room[0].id">Add program</inertia-link>
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
                    <div>
                    <jet-label for="camera_name" value="Camera Name:" />
                    <jet-input id="camera_name" type="text" class="mt-1 block w-full" v-model="camera_name"/>
                    </div>
                    <div>
                    <jet-label for="camera_url" value="Camera Url:" />
                    <jet-input id="camera_url" type="text" class="mt-1 block w-full" v-model="camera_url"/>
                    </div>    
                    <jet-button class="ml-4" :click="add_camera" >
                        Add Camera
                    </jet-button>

                    </div>
                    <inertia-link :href="'/lobby/'+room[0].id"> Enter into lobby <BIconArrowRightSquareFill class="bg-green-500"/></inertia-link>

                </div>
        </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    //import Welcome from '@/Jetstream/Welcome'
    import {BIconArrowRightSquareFill} from 'bootstrap-icons-vue';
    import axios from 'axios';

    export default {
        components: {
            AppLayout,
            Welcome,
            BIconArrowRightSquareFill
            
        },
        data:
        {
            camera_name:"",
            camera_url:""
        },
        props: {
            room:{ 
                type:Array,
                required: true
            }
        },
        methods:{
            add_camera()
            {
                axios.post("add-camera-room/"+room[0].id,{
                "camera_name":camera_name,
                "camera_url": camera_url
                })
            }

        }
    }
</script>