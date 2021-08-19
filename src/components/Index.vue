<template>
	<div id="vue-js-index-container">
		<md-app md-waterfall md-mode="fixed" :md-theme="userTheme">
			<md-app-toolbar class="md-primary" md-elevation="5">
				<md-button class="md-icon-button" @click="toggleMenu" v-if="!menuVisible">
					<md-icon>menu</md-icon>
				</md-button>
				<router-link class="router-link" to="/home">
					<logo height="50pt" style="fill: white" />
					<span class="md-title">Escape Room Management Room</span>
				</router-link>
				</md-app-toolbar>

			<md-app-drawer :md-active.sync="menuVisible" md-persistent="mini">
				<md-toolbar class="md-transparent" md-elevation="3">
					<span>Navigation</span>
					<div class="md-toolbar-section-end">
						<md-button class="md-icon-button md-dense" @click="toggleMenu">
							<md-icon>keyboard_arrow_left</md-icon>
						</md-button>
					</div>
				</md-toolbar>

				<md-list>
					<div v-for="tab in menuTab" :key="tab.title">
						<router-link :to="tab.link">
							<md-list-item v-if="tab.auth" :class="{'active': $route.fullPath.includes(tab.link)}">
								<md-icon class="md-icon">{{tab.icon}}</md-icon>
								<span class="md-list-item-text">{{tab.title}}</span>
							</md-list-item>
							
						</router-link>
					</div>
					<md-list-item v-if="true" v-on:click="logout()">
								<md-icon class="md-icon">logout</md-icon>
								<span class="md-list-item-text"></span>
					</md-list-item>
				</md-list>
			</md-app-drawer>

			<md-app-content>
				<router-view/>
			</md-app-content>
			<md-switch v-model="themeSwitch" @change="changeTheme">Theme light/dark</md-switch>
		</md-app>
	</div>
</template>

<script>
import {FirebaseAuth} from "@/firebase";
import logo from '@/assets/logo';
	export default {
		components: {
		logo
		},
		name: 'Index',
		data: () => ({
			menuVisible: false,
			userTheme: "default",
			menuTab: [
				{
					icon: 'home',
					title: 'Home',
					link: '/home',
					auth: true,
				},
				{
					icon: 'place',
					title: 'room',
					link: '/room',
					auth: true,
				},
				{
					icon: 'map',
					title: 'devices',
					link: '/devices',
					auth: true,
				},
				{
					icon: 'info',
					title: 'Info',
					link: '/info',
					auth: true,
				},
				{
					icon: 'person',
					title: 'Account',
					link: '/account',
					auth: true,
				},
			
			]
		}),
		mounted() {
			if (localStorage.userTheme === "dark") {
				this.userTheme = "dark";
			}
			if (this.$route.fullPath === '/') {
				this.$router.replace('/home').catch(() => {
				});
			}
		},
		methods: {
			toggleMenu() {
				this.menuVisible = !this.menuVisible;
			},
			logout: function () {
				this.loading = true;
				let _this = this;
				FirebaseAuth.signOut().then(() => {
					// Automatic redirect to login (onAuthStateChanged)
					_this.$noty.success("Logout confirmed", {
						killer: true,
						timeout: 1500,
					});
					this.$router.replace('/account/login').catch(() => {}); // User not logged
				}).catch((error) => {
					console.log("signOut()", error);
					_this.$noty.error("Logout error, please refresh the page.");
				});
			}
		}
	}
</script>

<style lang="scss">
	@import "../../src/style/variables.scss";

	#vue-js-index-container {
		.md-app {
			height: 100vh;

			.router-link {
				display: flex;
				align-items: center;
			}

			.bar-logo {
				width: 35px !important;
			}

			.md-app-drawer {
				max-width: 300px !important;
			}

			.md-list-item {

				&:hover {
					.md-icon {
						color: $accent;
						opacity: 0.8;
					}

					.md-list-item-text {
						color: $accent;
						transition: color .4s cubic-bezier(.4,0,.2,1);
						opacity: 0.8;
					}
				}

				&.active {
					.md-icon {
						color: $accent;
					}

					.md-list-item-text {
						color: $accent;
					}
				}

				.md-list-item-text {
					font-weight: bold;
				}
			}
		}
	}
</style>
