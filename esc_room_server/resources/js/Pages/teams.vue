<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teams
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
      <th class="w-1/3 ...">Team Names:</th>
      <th class="w-1/3 ...">Management</th>
    </tr>
  </thead>
  <tbody>
      <tr v-for="(row, index)  in teams" :key="row.id">
       <td>{{ index+1 }}</td>
       <td>{{ row.name }}</td>
       <td><inertia-link :href="'/team/'+row.id">Show previous runs of team</inertia-link></td>
     </tr>
   </tbody>
<tfoot>
    <tr>
      <td class="w-1/3 ..."></td>
      <td class="w-1/3 ...">
     <div>
                <jet-label for="name" value="Name of team" />
                <jet-input aria-placeholder="Enter team name..." id="name" type="name" class="mt-1 block w-full" v-model="add_name" required autofocus />
      </div>
      
      </td>
      
      <td class="w-1/5 ...">
      <jet-button class="ml-4" v-on:click="submit">
                    Add Team
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
    import axios from 'axios';
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import JetLabel from '@/Jetstream/Label'
    import JetButton from '@/Jetstream/Button'
    import JetInput from '@/Jetstream/Input'

    export default {
        
        props: {
            teams:{ 
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
            JetLabel
            
        },
        methods: {
            submit() {
                axios.post('/create-rteam',{name:this.add_name});
                Inertia.visit('/teams', {only: ['teams'],});
            }
        }
    }

    
</script>