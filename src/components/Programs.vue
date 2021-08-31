<template>
<div class="center">
<h2>Programs</h2>
<div class="section">
    <md-table  md-card>
      <md-table-toolbar>
        <h1 class="md-title">Programs</h1>
      </md-table-toolbar>
      <md-table-row>
        <md-table-head md-numeric>#</md-table-head>
        <md-table-head>Program Name:</md-table-head>
        <md-table-head>Program is Active:</md-table-head>
      </md-table-row>
      
      <md-table-row v-for="(row,index) in programs" :key="row.i">
        <md-table-cell md-numeric>{{index+1}}</md-table-cell>
        <md-table-cell>{{row.name}}</md-table-cell>
        <md-table-cell>{{row.mode}}</md-table-cell>
    </md-table-row>
      
      </md-table>
      
    </div>
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
      showDialog: false,
      programs:[]
    })
  }
</script>
