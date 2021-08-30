<template>
<tbody>
    
    </tbody>
</template>
<script>
export default {
    data()
    {return{
        rows:[]}
    },
    mounted()
    {
        this.rows=JSON.parse(localStorage.getItem("rows"));
        localStorage.removeItem("rows");
    }
    }
    
    
</script>