<template>
  <select class="block w-full pl-3 pr-10 py-2 transition duration-100 ease-in-out border rounded shadow-sm focus:ring-2 focus:ring-blue-500 focus:outline-none focus:ring-opacity-50 disabled:opacity-50 disabled:cursor-not-allowed text-black placeholder-gray-400 bg-white border-gray-300 focus:border-blue-500">
      <option disabled value="">Please select one</option>
      <option v-for="option in options" :key="option.id" :value="option.id">{{option.text}}</option>
  </select>
</template>

<script>

    export default {
        props:{
        options:{ 
                type:Array,
                required: true
            } 
        },
        emits: ['update:options'],

        methods: {
            focus() {
                this.$refs.input.focus()
            }
        },
        mounted() {
            console.log(this.options);
        }
    }
</script>

