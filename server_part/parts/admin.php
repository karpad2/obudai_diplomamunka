<?php
if(isset($_GET["ajax"]))
{
    include ("../config.php");
    $sql="select config_text from config where config_name='{$_GET["ajax"]}'";
    $res=e_sql($sql,GET_ASSOC);
    die(json_encode($res[0]));
}
 if(isset($_POST["config_name"]))
{
    if(isset($_SESSION["user"]["admin_mod"]) and ($_SESSION["user"]["admin_mod"]=="1") )
    $sql="update config set config_text='{$_POST["config_text"]}' where config_name='{$_POST["config_name"]}';";
    e_sql($sql,GET_INSERT_ID);
    set_status("Config modified");
}
    if(isset($_SESSION["user"]["admin_mod"]))
    {
        if($_SESSION["user"]["admin_mod"]=="1")
        {
            $sql="select config_name,config_text from config";
            $res=e_sql($sql,GET_ASSOC);
            //var_dump($res);

            echo '<form method="post" action="index.php?mod=admin"> <select name="config_name" id="config_name" class="form-select" aria-label="Default select example">';
            $i="1";
            foreach ($res as $re)
            {
                echo "<option value=\"{$re["config_name"]}\">{$re["config_name"]}</option>";
                $i++;
            }
            echo '</select>';

            echo "<textarea id=\"config_text\" class='form-control' rows='14' name=\"config_text\">{$res[0]["config_text"]}</textarea>
                <input type='submit' class='btn btn-primary' value='Save' />";

        echo "</form>";
        }
    }
    else die("");?>

<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
<script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>

<!-- Theme included stylesheets -->
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href="//cdn.quilljs.com/1.3.6/quill.bubble.css" rel="stylesheet">
<script>
   // console.log(document.getElementById("config_name"));
    document.getElementById("config_name").onchange=()=>{
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                let text= JSON.parse(this.responseText);
                document.getElementById("config_text").innerHTML = text.config_text;
            }
        };
        xhttp.open("GET", "./parts/admin.php?ajax="+document.getElementById("config_name").value, true);
        xhttp.send();

    };



</script>

