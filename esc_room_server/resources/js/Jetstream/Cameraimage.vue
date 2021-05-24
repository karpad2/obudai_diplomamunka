<template>
    <modal :show="show" :max-width="maxWidth" :closeable="closeable" @close="close">
        <div class="px-6 py-4">
            <div class="text-lg">
                {{camera_name}}
            </div>

            <div class="mt-4">
                <div class="cam-container">
                <img alt="camera-stream" :src="imgUrl" class="w-100" />
                <div class="cam-name">Kamera: {{camera_name}}</div>
                <div class="cam-timestamp">{{time_string}}</div>
            </div>
            </div>
        </div>

        <div class="px-6 py-4 bg-gray-100 text-right">
            
        </div>
    </modal>
</template>

<script>
    import * as moment from 'moment'
    import Modal from '@/Jetstream/Modal'

    export default {
        emits: ['close'],
        components: {
            Modal,
        },
         data(){
            return {
                time_string:""
            }},
        props: {
            show: {
                default: false
            },
            maxWidth: {
                default: '2xl'
            },
            closeable: {
                default: true
            },
            camera_name:"",
            imgUrl:""
        },

        methods: {
            close() {
                this.$emit('close')
            },
            update_data()
            {
            
            this.time_string=moment().format('LTS');
            }
        },
        created() {
            moment.locale(); 
            setInterval(()=>{
            this.update_data();      
            },1000);
        }
    }
</script>

<style>
.cam-container
{
  position: relative;
  text-align: center;
  color: black;
}
.cam-name {
  position: absolute;
  top: 8px;
  left: 16px;
}

.cam-timestamp {
  position: absolute;
  bottom: 8px;
  right: 16px;
}
</style>