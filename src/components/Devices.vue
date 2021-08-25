<template>
<div class="center">
<h2>Devices</h2>


<h2>Searching for Devices</h2>
<md-list v-if="!found_devices || !found_devices.length">
    <md-list-item>
    </md-list-item>
</md-list>

<md-list v-for="fdevice in found_devices" :key="fdevice.device_id">
 <md-list-item>
        <md-avatar>
          <img src="https://placeimg.com/40/40/people/6" alt="People">
        </md-avatar>

        <span class="md-list-item-text">Mary Johnson</span>

        <md-button class="md-icon-button md-list-action">
          <md-icon>chat_bubble</md-icon>
        </md-button>
      </md-list-item>
</md-list>

<md-dialog :md-active.sync="showDialog">
	<md-dialog-title>Add Program</md-dialog-title>
	<md-text>
		
		
	</md-text>
	<md-dialog-actions>
	<md-button class="md-primary" @click="showDialog = false">Close</md-button>
    <md-button class="md-primary md-raised" @click="showDialog = false">Save</md-button>
	</md-dialog-actions>
</md-dialog>

 <md-button class="md-raised md-primary">Add device</md-button>
</div>
</template>
<script>
export default {
    name: 'Devices',
    data: () => ({
      showDialog: false,
      scan : navigator.bluetooth.requestLEScan({"acceptAllAdvertisements":true}),
      found_devices:[]
    }),
    mounted()
    {
        navigator.bluetooth.addEventListener('advertisementreceived',this.findADevice(event));

    },
    methods:
    {
        findADevice(event)
        {
            this.found_devices.push(
                {
                    name:event.device_name,
                    device_id:event.device.id
                }
            )
        },
        stopScan() {
            console.log('Stopping scan...');
            this.scan.stop();
            console.log('Stopped.  scan.active = ' + this.scan.active);
            },
        search_devices()
        {   
            
            setTimeout(this.stopScan, 10000);
             
  
        }


        }
    
  }

</script>
