<template>
	<div>
	</div>
</template>

<script>
	export default {
		name: "Home",
		data: () => ({
			selectedMovies: [],
			selectedDate: null,
			boolean: false
		}),
		computed: {
			firstDayOfAWeek: {
				get() {
					return this.$material.locale.firstDayOfAWeek;
				},
				set(val) {
					this.$material.locale.firstDayOfAWeek = val;
				}
			},
			dateFormat: {
				get() {
					return this.$material.locale.dateFormat;
				},
				set(val) {
					this.$material.locale.dateFormat = val;
				}
			}
		},
		methods: {
			showSuccess: function () {
				this.$noty.success("Success!");
			},
			showError: function () {
				this.$noty.error("Error :(", {
					killer: true,
					timeout: 1500,
				});
			}
		}
	}
</script>

<style scoped>
	
</style>