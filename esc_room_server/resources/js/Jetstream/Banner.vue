<template>
    <div>
        <div :class="{ 'bg-indigo-500': style == 'success', 'bg-red-700': style == 'danger' }" v-if="show && message">
            <div class="max-w-screen-xl mx-auto py-2 px-3 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between flex-wrap">
                    <div class="w-0 flex-1 flex items-center min-w-0">
                        <span class="flex p-2 rounded-lg" :class="{ 'bg-indigo-600': style == 'success', 'bg-red-600': style == 'danger' }">
                            
                            <BIconCheck2 class="h-5 w-5 text-white" v-if="style == 'success'"/>
                            

                            <BIconExclamationTriangle class="h-5 w-5 text-white" v-if="style == 'danger'" />
                        </span>

                        <p class="ml-3 font-medium text-sm text-white truncate">
                            {{ message }}
                        </p>
                    </div>

                    <div class="flex-shrink-0 sm:ml-3">
                        <button
                            type="button"
                            class="-mr-1 flex p-2 rounded-md focus:outline-none sm:-mr-2 transition ease-in-out duration-150"
                            :class="{ 'hover:bg-indigo-600 focus:bg-indigo-600': style == 'success', 'hover:bg-red-600 focus:bg-red-600': style == 'danger' }"
                            aria-label="Dismiss"
                            @click.prevent="show = false"> 
                            <BIconX class="h-5 w-5 text-white" />
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {BIconCheck2,BIconExclamationTriangle,BIconX} from 'bootstrap-icons-vue';
    export default {
        components: {
            BIconCheck2,
            BIconExclamationTriangle,
            BIconX
            },
        data() {
            return {
                show: true,
            }
        },

        computed: {
            style() {
                return this.$page.props.jetstream.flash?.bannerStyle || 'success'
            },

            message() {
                return this.$page.props.jetstream.flash?.banner || ''
            },
        }
    }
</script>
