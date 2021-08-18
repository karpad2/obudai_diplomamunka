<template>
  <!-- ... -->
  <VueWebble
    filter-type="all"
    :services="[
      'alert_notification'
    ]"
    @scanned-devices="handleScannedDevices"
    @connected-devices="handleConnectedDevices"
  />
  <!-- ... -->
</template>

<script>
import VueWebble from "vue-webble";

export default {
  // ...
  components: {
    VueWebble
  }
};
</script>