<?php
$login_form='<main class="form-signin">
<form action="index.php?mod=login" method="post">
<div class="simple-login-container">
    <h2>Login Form</h2>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="text" class="form-control" placeholder="Username">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="password" placeholder="Enter your Password" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="submit" class="btn btn-block btn-login" placeholder="Enter your Password" >
        </div>
    </div>
    
</div>
</form></main>';


$login_form2='<main class="form-signin">
  <form>
    <img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
    <h1 class="h3 mb-3 fw-normal">Please sign in</h1>
    <label for="inputEmail" class="visually-hidden">Email address</label>
    <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
    <label for="inputPassword" class="visually-hidden">Password</label>
    <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" value="remember-me"> Remember me
      </label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
    
  </form>
</main>';

$register_form='
<main class="form-signin">
<form action="index.php?mod=register" method="post">
<div class="simple-login-container">
    <h2>Register Form</h2>
    <div class="row">
    <div class="col-md-12 form-group">
            <input type="hidden" class="form-control" name="register" placeholder="Username">
        </div>
        <div class="col-md-12 form-group">
            <input type="text" class="form-control" name="username" placeholder="Felhasználó">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="password" name="pass1" placeholder="Enter your Password" class="form-control">
        </div>
    </div>
     <div class="row">
        <div class="col-md-12 form-group">
            <input type="password" name="pass2" placeholder="Please write password again" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="submit" class="btn btn-block btn-login" placeholder="Regisztráció" >
        </div>
    </div>
    
</div></form></main>';
switch($_GET["mod"]) {
    case "login": echo $login_form2; break;
    case "register" :echo $register_form; break;

}
if(isset($_GET["login"])) {  if(isset($_POST["login"])) login_in($_POST["username"],$_POST["password1"]);}
else if(isset($_GET["register"])) { if(isset($_POST["register"])) register($_POST["username"],$_POST["pass1"],$_POST["pass2"]);}
else if(isset($_GET["logout"])) logout();
else {

}


?>
