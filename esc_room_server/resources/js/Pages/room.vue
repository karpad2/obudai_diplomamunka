<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Room - {{room[0].name}}
            </h2>
        </template>
<div class="py-12">
       <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="p-6 sm:px-20 bg-white border-b border-gray-200">
                    <div class="col-span-full md:col-span-4">
                    <h1 class=" inline text-xl text-white bg-purple-800 p-2 capitalize">Management Room</h1>
                    <div class="flex flex-col items-start justify-center bg-purple-100 p-6 ">
                    <div v-if="run.length===0">
                    <span >Run is active!</span>
                    <LinkButton :href="'/run/'+room[0].id">Enter into Room</LinkButton>
                    </div>
                    <div v-else>
                    <span ></span>
                    <LinkButton :href="'/lobby/'+room[0].id">Enter into Lobby</LinkButton>
                    </div>
                    <LinkButton :href="'/create-program/'+room[0].id">Add program</LinkButton>

                    <LinkButton :href="'/past-runs/'+room[0].id">Show previous runs</LinkButton>
                    </div>
                    </div>
                    <div class="col-span-full md:col-span-8">
                    <h1 class=" inline text-xl text-white bg-purple-800 p-2 capitalize">Devices</h1>
                    <div class="flex flex-col items-start justify-center bg-purple-100 p-6 ">
                        <h2>Assign devices to room</h2>
                        <Select v-model="selected_device" :options="list_device"/>
                         <jet-button class="ml-4" v-on:click="add_device" >
                            Add Device
                        </jet-button>
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
                    <jet-button class="ml-4" v-on:click="add_camera" >
                        Add Camera
                    </jet-button>

                    </div>
                </div>
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
    import JetLabel from '@/Jetstream/Label'
    import JetInput from '@/Jetstream/Input'
    import JetButton from '@/Jetstream/Button'
    import LinkButton from '@/Jetstream/LinkButton'
    import Select from '@/Jetstream/Select'

    export default {
        components: {
            AppLayout,
            BIconArrowRightSquareFill,
            JetLabel,
            JetInput,
            JetButton,
            Select,
            LinkButton
        },
        data()
        {
            return{
            camera_name:"",
            camera_url:"",
            list_device:[
               
            ],
            selected_device:""}
        },
        props: {
            room:{ 
                type:Array,
                required: true
            },
            devices:{ 
                type:Array,
                required: true
            },
            run:{ 
                type:Array,
                required: true
            },
            
        },
        methods:{
            add_camera()
            {
                axios.post("/add-camera-room/"+this.room[0].id,{
                camera_name:this.camera_name,
                camera_url: this.camera_url
                })
            },
            add_device()
            {
                axios.post("/add-camera-room/"+this.room[0].id,{
                camera_name:this.camera_name,
                camera_url: this.camera_url
                })
            },
            device_to_list(devices)
            {
                devices.forEach((item) =>
                {
                this.list_device.push(
                {
                    id:item.id,
                    text:item.name
                })
                })

            }


        },
        mounted() {
            this.device_to_list(this.devices);
            console.log(this.device_to_list);
            
            }   
    }
</script>