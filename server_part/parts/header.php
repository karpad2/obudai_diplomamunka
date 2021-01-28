<!document html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?php get_title_name()?></title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="favicon.png">
    <script src="js/bootstrap.bundle.min.js"></script>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="<?php echo get_config_text("author");  ?>">
</head>
<body>

<header class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
    <p class="h5 my-0 me-md-auto fw-normal"><?php echo get_config_text("website-name");  ?></p>
    <nav class="my-2 my-md-0 me-md-3">
        <a class="p-2 text-dark" href="#">Features</a>
        <a class="p-2 text-dark" href="#">Enterprise</a>
        <a class="p-2 text-dark" href="#">Support</a>
        <a class="p-2 text-dark" href="#">About us</a>

    <a class="p-2 btn btn-outline-primary" href="index.php?mod=login">Sign in</a>
    <a class="p-2 btn btn-outline-primary" href="index.php?mod=register">Sign up</a>
    </nav>
</header>
<main class="container">
<?php if(isset($_SESSION["errormessage"]))
{echo '<div class="alert alert-danger" role="alert">'.$_SESSION["errormessage"].'</div>';unset($_SESSION["errormessage"]);
}?>
<?php if(isset($_SESSION["successmessage"]))
{echo '<div class="alert alert-success" role="alert">'.$_SESSION["successmessage"].'</div>';unset($_SESSION["successmessage"]);
}?>

