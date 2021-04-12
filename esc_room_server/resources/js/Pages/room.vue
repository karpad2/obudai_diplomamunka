<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Room - {{room[0].name}}
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <inertia-link class="w-30 flex items-center justify-center rounded-md bg-black text-white" :href="'run/'+room[0].id">
                    Start
                    </inertia-link>


                    <div>
                    Assign devices to room

                    </div>
                    
                    <div>
                    Assign cameras to room


                    </div>

                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'

    export default {
        components: {
            AppLayout,
            Welcome,
        },
        props: {
            room:{ 
                type:Array,
                required: true
            }
        }
    }
</script>