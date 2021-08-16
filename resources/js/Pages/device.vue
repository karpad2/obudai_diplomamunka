<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Device {{device[0].name}}
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="p-6 sm:px-20 bg-white border-b border-gray-200">

               <div class="mt-4">
                <jet-label for="device-name" value="Name"/>
                <jet-input id="device-name" type="text" class="mt-1 block w-full" v-model="device[0].name" v-on:change="changename"/>
            </div>
               <p><Deviceactivity :lastonline="device[0].last_online" />
                
               </p>
               <p>Mode: {{device[0].mode}} <Select v-model="device[0].mode" :options="devicemods" v-on:change="changeselect"/></p>
               <p>Status: 
                <span v-if="device[0].mode=='relay'">
                <label class="flex items-center">
                    <jet-checkbox name="remember" :v-model:checked="device[0].status" @change="save"/>
                    <span class="ml-2 text-sm text-gray-600">Activate</span>
                </label></span>
                
                <span v-if="device[0].mode=='rfid'">
                <label class="flex items-center">
                    <span class="ml-2 text-sm text-gray-600">RFID Code:</span>
                    <input :v-model="device[0].text" disabled />
                   </label></span>

                <span v-if="device[0].mode=='display'">
                <label class="flex items-center">
                    <span class="ml-2 text-sm text-gray-600">Display message:</span>
                    <input :v-model="device[0].text" :change="save_text" />
                    </label></span>

                <span v-if="device[0].mode=='input'">
                <label class="flex items-center">
                    <span class="ml-2 text-sm text-gray-600">Active:</span>
                    <jet-checkbox name="remember" :v-model:checked="device[0].status" disabled />  
                </label>
                </span>

                </p>
            <div class="flex items-center justify-end mt-4">
             <jet-button class="ml-4" @click="save">Save</jet-button>
               </div>
               </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import JetButton from '@/Jetstream/Button'
    import JetCheckbox from '@/Jetstream/Checkbox'
    import Select from '@/Jetstream/Select'
    import JetInput from '@/Jetstream/Input'
    import JetLabel from '@/Jetstream/Label'
    import Deviceactivity from '@/Jetstream/Deviceactivity'
    import { Inertia } from '@inertiajs/inertia'
     
    export default {
        components: {
            AppLayout,
            JetButton,
            JetInput,
            JetLabel,
            JetCheckbox,
            Select,
            Deviceactivity
            
        },
        props: {
            device:{
                type:Array,
                required: true
            },
        },
        data (){
            return {
                devicemods:[
                {
                    id:"relay",
                    text:"Relay"
                },
                {
                    id:"rfid",
                    text:"RFID reading"
                },
                {
                    id:"input",
                    text:"Input"
                },
                {
                    id:"display",
                    text:"Displaying"
                }
            ],
            time_string:"",
            active:true
            }
        },
        methods:
        {
            changename()
            {
            axios.get('/api/device/js-api-name/'+this.device[0].id+'/'+this.device[0].name);
            },
            changeselect()
            {
            this.send_data(this.device[0].id,this.device[0].mode,'0');
            },
            save()
            {
            this.send_data(this.device[0].id,this.device[0].mode,this.device[0].status==true?1:0);
            },
            
            save_text()
            {
                this.send_data(this.device[0].id,this.device[0].mode,this.device[0].text);
            },

            send_data(id,mode,status)
            {
            axios.get('/api/device/js-api/'+id+'/'+mode+'/'+status);
            },
            update_data()
            {
                   

                if(this.device[0].mode=="rfid" || this.device[0].mode=="input")
                {
                    axios.get('/api/device/js-status/'+this.device[0].password).then((res)=>{
                     this.device[0]=res.data;   
                    });
                }
            }
        },
        created() {
            setInterval(()=>{
            this.update_data();      
            },1000);
        }



    }
</script>
