<?php
if(isset($_GET["mod"]))
{
    switch ($_GET["mod"])
    {
        case "welcome":
            {
                echo '<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">';
                $sql="select UPPER(tier) as 'tier', escape_room, devices, price from tiers order by price asc";
                $res=e_sql($sql,GET_ASSOC);
                var_dump($res);
                foreach ($res as $re)
                {
           echo "<div class=\"col\">
        <div class=\"card mb-4 shadow-sm\">
            <div class=\"card-header\">
                <h4 class=\"my-0 fw-normal\">{$re["tier"]}</h4>
            </div>
            <div class=\"card-body\">
                <h1 class=\"card-title pricing-card-title\">$ {$re["price"]} <small class=\"text-muted\">/ mo</small></h1>
                <ul class=\"list-unstyled mt-3 mb-4\">";
               echo"<li>";
                echo  $re["devices"]=="9999"?"<img class=\"mb-2\" src=\"media/infinite.svg\" alt=\"infinite\" width=\"24\" height=\"19\">":$re["devices"];
                echo " device supported</li>";
                    echo"<li>";
                    echo  $re["escape_room"]=="9999"?"<img class=\"mb-2\" src=\"media/infinite.svg\" alt=\"infinite\" width=\"24\" height=\"19\">":$re["escape_room"];
                    echo " escape room supported</li>";
              if(isset($re["extra"])) echo"<li>{$re["extra"]}</li>";
                 echo "</ul>
                <button type=\"button\" class=\"w-100 btn btn-lg btn-outline-primary\">Sign up for {$re["tier"]}</button>
            </div>
        </div>
    </div>";
                }
                echo '</div>';
            } break;




        // echo get_config_text('welcome_text'); break;
        case "about_us": echo get_config_text('about_us'); break;
        case "privacy": echo get_config_text('privacy'); break;
        default :
    }
}
else
{
   // echo get_config_text('welcome_text');
    header("Location:index.php?mod=welcome");
}

