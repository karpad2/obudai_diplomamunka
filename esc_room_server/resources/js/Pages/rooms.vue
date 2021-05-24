<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Rooms
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
      <tr v-for="(row, index)  in rooms" :key="row.id">
       <td>{{ index+1 }}</td>
       <td>{{ row.name }}</td>
       <td><inertia-link :href="'/room/'+row.id">Enter into room <BIconArrowRightSquareFill class="bg-green-500"/></inertia-link> <span :v-on:click="delete"><i class="bi bi-trash"></i> </span> </td>
     </tr>
   </tbody>
<tfoot>
    <tr>
      <td class="w-1/3 ..."></td>
      <td class="w-1/3 ...">
     <div>
                <jet-label for="name" value="Name of room" />
                <jet-input aria-placeholder="Enter room name..." id="name" type="name" class="mt-1 block w-full" v-model="add_name" required autofocus />
      </div>

      </td>

      <td class="w-1/5 ...">
      <jet-button class="ml-4" v-on:click="submit">
                    Add Room
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
    import {BIconArrowRightSquareFill} from 'bootstrap-icons-vue';

import Button from "../Jetstream/Button";

    export default {

        props: {
            rooms:{
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
            Button,
            AppLayout,
            JetButton,
            JetInput,
            JetLabel,
            BIconArrowRightSquareFill

        },
        methods: {
            submit() {
                axios.post('/create-room',{name:this.add_name});
                Inertia.visit('/rooms', {only: ['rooms'],});
            }
        }
    }


</script>
