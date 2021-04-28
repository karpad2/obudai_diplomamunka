<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Cameras
            </h2>
        </template>

        <div class="py-12">
<div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
<div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
<div>
<div class="bg-white shadow-md rounded my-6">
<table class="min-w-max w-full table-auto">
<thead>
    <tr>
      <th class="w-1/4 ...">#</th>
      <th class="w-1/3 ...">Name:</th>
      <th class="w-1/3 ...">Camera Show</th>
    </tr>
  </thead>
  <tbody>
      <tr v-for="row in cameras" :key="row.id">
       <td>{{ row.id }}</td>
       <td>{{ row.name }}</td>
       <td><jet-button v-on:click="open_camera(row.camera_url)">Show camera<BIconArrowRightSquareFill class="bg-green-500"/></jet-button> <span v-on:click="delete"><i class="bi bi-trash"></i> </span> </td>
     </tr>
   </tbody>
<tfoot>
    <tr>
      <td class="w-1/3 ..."></td>
      <td class="w-1/3 ...">
    

      </td>

      <td class="w-1/5 ...">
    
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
            cameras:{
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
            open_camera(url)
            {
                console.log("Opening popup");
                window.open(this.url);
            }
           
        }
    }


</script>
