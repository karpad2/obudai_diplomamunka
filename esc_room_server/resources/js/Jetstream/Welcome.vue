<template>
    <div>
        <div class="p-6 sm:px-20 bg-white border-b border-gray-200">
            <div>
                <jet-application-logo class="block h-12 w-auto" />
            </div>

            <div class="mt-8 text-2xl">
                Welcome in Escape Room Management application!
            </div>

            <div class="mt-6 text-gray-500">
            Escape management application provides direct control to your ESP32 devices, You can programmed with them with this application GUI.
            We hope you will like it.
            </div>
        </div>

        <div class="bg-gray-200 bg-opacity-25 grid grid-cols-1 md:grid-cols-2">

            <div class="p-6 border-t border-gray-200 md:border-t-0 md:border-l">
                <div class="flex items-center">
                    <BIconCamera class="w-8 h-8 text-gray-400"/>
                    <div class="ml-4 text-lg text-gray-600 leading-7 font-semibold"><a href="/cameras">Cameras</a></div>
                </div>

                <div class="ml-12">
                    <div class="mt-2 text-sm text-gray-500">
                    Escape Room management application gives lot of functionality to improve your Escape Room network. Check them out, see yourself.
                    </div>

                    <span>
                        <div class="mt-3 flex items-center text-sm font-semibold text-indigo-700">
                                <div>Check Cameras</div>
                                
                                <div >
                                <BIconArrowRight class="ml-1 text-indigo-500" />
                                </div>
                        </div>
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import JetApplicationLogo from '@/Jetstream/ApplicationLogo'
    import {BIconCamera,BIconArrowRight} from 'bootstrap-icons-vue';
    export default {
        components: {
            JetApplicationLogo,
            BIconCamera,
            BIconArrowRight
        },
    }
</script>
