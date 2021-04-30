<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Device {{device[0].name}}
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
               <p>Last online: {{device[0].last_online}}</p>
               <p>Mode: {{device[0].mode}}</p>
               <p>Status: 
                <label class="flex items-center">
                    <jet-checkbox name="remember" v-model:checked="device[0].status" @change="save"/>
                    <span class="ml-2 text-sm text-gray-600">Activate</span>
                </label></p>

                


               <div class="flex items-center justify-end mt-4">
                    <jet-button class="ml-4" @click="save">
                    Save
                </jet-button>
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
    export default {
        components: {
            AppLayout,
            JetButton,
            JetCheckbox,
        },
        props: {
            device:{
                type:Array,
                required: true
            },
        },
        data: ()=>
        {
            return
            {
                status:device[0].status
                el:device[0]
            }
        },
        methods:
        {
            save()
            {
                this.send_data(this.device[0].id,this.device[0].mode,this.device[0].status==true?1:0);
            },
            
            send_data(id,mode,status)
            {
            axios.get('/api/device/js-api/'+id+'/'+mode+'/'+status);
            },
        }



    }
</script>
