<template>
    <md-field>
      <label>{{label}}}}</label>
      <md-input :v-model="modelValue" @input="$emit('update:modelValue', $event.target.value)"></md-input>
    </md-field>
</template>
<script>
export default {
    props:['label','modelValue'],
    emits: ['update:modelValue'],
}
</script>