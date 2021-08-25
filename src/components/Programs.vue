<template>
<div class="center">
<h2>Programs</h2>
<md-dialog :md-active.sync="showDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>

<md-button class="md-raised md-primary" @click="showDialog = true">Add program</md-button>
</div>
</template>
<script>
export default {
    name: 'Programs',
    data: () => ({
      showDialog: false
    })
  }
</script>
