<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Devices
            </h2>
        </template>

        <div class="py-12">
<div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
<div class="p-6 sm:px-20 bg-white border-b border-gray-200">
<div>
<div class="bg-white shadow-md rounded my-6">
<table class="min-w-max w-full table-auto">
<thead>
    <tr>
      <th class="w-1/4 ...">#</th>
      <th class="w-1/3 ...">Name:</th>
      <th class="w-1/3 ...">Management</th>
    </tr>
  </thead>
  <tbody>
      <tr v-for="row in devices" :key="row.id">
       <td>{{ row.id }}</td>
       <td>{{ row.name }}</td>
       <td><inertia-link :href="'/device/'+row.id">Manage your device <BIconGearFill /></inertia-link></td>
     </tr>
   </tbody>
<tfoot>
    <tr>
      <td class="w-1/3 ..."></td>
      <td class="w-1/3 ...">
     <div>
                <jet-label for="name" value="Enter your device id here..." />
                <jet-input aria-placeholder="Enter your device id here..." id="name" type="name" class="mt-1 block w-full" v-model="add_name" required autofocus />
      </div>
      
      </td>
      
      <td class="w-1/5 ...">
      <jet-button class="ml-4" v-on:click="submit">
                    Add Device
       </jet-button>
      </td>
      </tr>
</tfoot></table>   


                    </div>
                  </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
import { Inertia } from '@inertiajs/inertia'
    import axios from 'axios';
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import JetLabel from '@/Jetstream/Label'
    import JetButton from '@/Jetstream/Button'
    import JetInput from '@/Jetstream/Input'
    import {BIconGearFill} from 'bootstrap-icons-vue';

    export default {
        
        props: {
            devices:{ 
                type:Array,
                required: true
            }
        },
         data() {
            return {
                add_name:""
                }
            
        },
        mounted: ()=>
        {
            //console.log(rows);
        },
        components: {
            AppLayout,
            JetButton,
            JetInput,
            JetLabel,
            BIconGearFill
            
        },
        methods: {
            submit() {
                axios.post('/add-user-device/',{dev_id:this.add_name});
                Inertia.visit('/devices', {only: ['devices'],});
            }
        }
    }

    
</script>