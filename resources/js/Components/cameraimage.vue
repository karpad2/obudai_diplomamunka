<template>
    <img alt="camera-stream" :src=imgUrl class="w-100" />
    <p>Kamera: {{camera_name}}</p>
</template>
<script>
import { BIconBatteryFull, BIconArrow90degDown, BIconBookmark } from 'bootstrap-icons-vue';

export default {
        data() {
            return {
                camera_name: '',
                imgUrl:''
            }
        },
}
</script>