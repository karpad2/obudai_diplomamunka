<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Programs
            </h2>
        </template>

        <div class="py-12">
<div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
<div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
<div>
<div class="bg-white shadow-md rounded my-6">
<table class="table-auto min-w-max w-full ">
<thead>
    <tr>
      <th class="w-1/5 ...">#</th>
      <th class="w-1/5 ...">Program Name:</th>
      <th class="w-1/5 ...">Room:</th>
      <th class="w-1/5 ...">Active:</th>
      <th class="w-1/5 ...">Management</th>
    </tr>
  </thead>
  <tbody>
      <tr v-for="row in programs" :key="row.id">
       <td class="w-1/5 ...">{{ row.id }}</td>
       <td class="w-1/5 ...">{{ row.name }}</td>
       <td class="w-1/5 ...">{{ row.room_id }}</td>
       <td class="w-1/5 ..."> <span v-if="row.active=='1'"> <BIconCheck2Square class="" /></span></td>
       <td class="w-1/5 ..."><inertia-link :href="'/update-program/'+row.id">Manage your Program <BIconGearFill /></inertia-link></td>
     </tr>
   </tbody>
</table>   
</div>
        </div>
      </div>
    </div>
  </div>
 </app-layout>
</template>

<script>
//
import { Inertia } from '@inertiajs/inertia'
    import axios from 'axios';
    import AppLayout from '@/Layouts/AppLayout'
    import JetLabel from '@/Jetstream/Label'
    import JetButton from '@/Jetstream/Button'
    import JetInput from '@/Jetstream/Input'
    import {BIconGearFill,BIconCheck2Square} from 'bootstrap-icons-vue';
    export default {
        
        props: {
            programs:{ 
                type:Array,
                required: true
            },
            rooms:{ 
                type:Array,
                required: true
            },
        },
         data() {
            return {
                add_name:"",
                room:""
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
            BIconGearFill,
            BIconCheck2Square
            
        },
        methods: {
            submit() {
                axios.post('/add-program/',{dev_id:this.add_name,room:this.room});
                Inertia.visit('/programs', {only: ['programs'],});
            }
        }
    }

/*

<tfoot>
    <tr>
      <td class="w-1/3 ..."></td>
      
      <td class="w-1/3 ...">
     <div>
                <jet-label for="name" value="Enter your program name here..." />
                <jet-input aria-placeholder="Enter your device id here..." id="name" type="name" class="mt-1 block w-full" v-model="add_name" required autofocus />
      </div>
      
      </td>
       <td class="w-1/3 ...">
     <div>
                <jet-label for="room" value="Choose your room here..." />
                <select v name="room" id="room" v-model="room">
                 <option v-for="row in rooms" :key="row.id" :value=row.id>{{row.name}}</option>   
                </select>
       </div>
      
      </td>
      
      <td class="w-1/5 ...">
      <jet-button class="ml-4" v-on:click="submit">
                    Add Program
       </jet-button>
      </td>
      </tr>
</tfoot>


*/
    
</script>