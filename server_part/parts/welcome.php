<?php
echo "<h1>Welcome on our website</h1>";


if(isset($_GET["mod"]))
{
    switch ($_GET["mod"])
    {
        case "welcome": echo get_config_text('welcome_text'); break;
        case "about_us": echo get_config_text('about_us'); break;
        default :
    }

}
else
{
    echo get_config_text('welcome_text');
}

