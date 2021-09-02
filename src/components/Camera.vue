<template>
<div class="center">
    <h2>Camera</h2>
    <Input label="Test" :modelValue="data"/>


</div>
</template>
<script>
import Input from "@/components/parts/Input";
export default
{
    data()
    {
        return{
            data:""
        }
    },
    components:
    {
        Input
    }
}

</script>
