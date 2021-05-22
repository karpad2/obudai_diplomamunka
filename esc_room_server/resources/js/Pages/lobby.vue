<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Lobby - {{teamname}}
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="p-6 sm:px-20 bg-white border-b border-gray-200">
                
                    <div class="mt-4">
                        <jet-label for="device-name" value="Team Name:"/>
                        <jet-input id="device-name" type="text" class="mt-1 block w-full" v-model="teamname" placeholder="Default"/>
                    </div>
            
            <LinkButton :href="'/run/'+room[0].id+'/'+teamname">Start</LinkButton>

        <table class="min-w-max w-full table-auto">
            <thead>
                <tr>
                    <th class="w-1/4 ...">#</th>
                    <th class="w-1/3 ...">Name:</th>
                    <th class="w-1/3 ...">Activity:</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="row in devices" :key="row.id">
                <td>{{ row.id }}</td>
                <td>{{ row.name }}</td>
                <td><Deviceactivity  :lastonline="row.last_online"/></td>
                </tr>
            </tbody>
        </table>

            </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import Blockly from 'blockly';
    import Deviceactivity from '@/Jetstream/Deviceactivity'
    import LinkButton from '@/Jetstream/LinkButton'
    import JetInput from '@/Jetstream/Input'
    import JetLabel from '@/Jetstream/Label'
    import 'blockly/javascript';

    export default {
        components: {
            AppLayout,
            Welcome,
            Blockly,
            Deviceactivity,
            LinkButton,
            JetInput,
            JetLabel
            
        },
        data(){
            return {
                teamname:"Default"
            }},
        props: {
            room:{ 
                type:Array,
                required: true
            },
            devices:{ 
                type:Array,
                required: true
            },
            programs:{ 
                type:Array,
                required: true
            }
        },
        methods:
        {
          changename (){

          }  
        }
    }
</script>