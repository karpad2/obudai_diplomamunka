<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Device
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
               <p>Last online: {{el.last_online}}</p>
               <p>Mode: {{el.mode}}</p>
               <p>Status: {{el.status}}</p>
               </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    export default {
        components: {
            AppLayout,
            
        },
        props: {
            device:{
                type:Array,
                required: true
            },
            el:this.device[0]
        }



    }
</script>
