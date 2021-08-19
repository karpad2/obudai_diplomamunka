<template>
	<div id="account-login-container">
		<md-field>
			<label>Email</label>
			<md-input id="email" v-model="email"></md-input>
		</md-field>

		<md-field>
			<label>Password</label>
			<md-input id="password" v-model="password" type="password"></md-input>
		</md-field>

		<p>{{errorMessage}}</p>

		<md-button class="md-raised md-primary" @click="login">Login</md-button>

		<md-field>
			<p>Or sign in with Google</p>
			<md-button class="md-raised md-primary" @click="loginwithgoogle">Login with <BIconGoogle /></md-button>
		</md-field>

	</div>
</template>

<script>
	import {Firebase,FirebaseAuth} from "@/firebase";
	import {BIconGoogle} from "bootstrap-icons-vue";

	export default {
		name: "AccountLogin",
		components: {
    		BIconGoogle
  			},
		data() {
			return {
				email: "",
				password: "",
				errorMessage: ""
			}
		},
		mounted() {
			FirebaseAuth.OAuthProvider((user) => {
				if (user && this.email === "") this.$router.replace('/account').catch(() => {
				}); // User already logged
			});
		},
		methods: {
			login: function () {
				if (this.email.length < 6 || this.password.length < 4) {
					this.errorMessage = "Insert email and password";
				} else {
					let _this = this;
					FirebaseAuth.signInWithEmailAndPassword(this.email, this.password).then(() => {
						this.password = "";
						
						this.$router.replace('/home'); // User logged
						this.set_user_data_local();
					}).catch((error) => {
						if (error.code === 'auth/wrong-password') {
							_this.errorMessage = "Password wrong";
						} else {
							_this.errorMessage = "Check email and password";
						}
					});
				}
			},
			loginwithgoogle: function()
			{
				let _this = this;
				let provider= new Firebase.auth.GoogleAuthProvider();
				FirebaseAuth.signInWithPopup(provider).then(()=>
				{
							
				this.$router.replace('/home');	
				this.set_user_data_local();
				}).catch((error) => {
						if (error.code === 'auth/wrong-password') {
							_this.errorMessage = "Password wrong";
						} else {
							_this.errorMessage = "Check email and password";
						}
					});
			}
		},
		set_user_data_local: function ()
		{	FirebaseAuth.onAuthStateChanged((user) => {
			localStorage.setItem('user',JSON.stringify(user));
			});
		}

		
	}
</script>

<style lang="scss">
	#account-login-container {

	}
</style>
