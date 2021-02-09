<?php
if(!isset($_GET["pr_mod"])) die("Internal error");
if($_GET["pr_mod"]=="new")
if(isset($_POST["program_name"]))
{
    $sql="insert into programs (program_name,user_id,room_id) values('{$_POST["program_name"]}','{$_SESSION["user"]["user_id"]}','{$_POST["room_id"]}');";
    $res=e_sql($sql,GET_INSERT_ID);
    header("Location:index.php?mod=program&program_id=".$res);
}
else{
$sql="select * from escape_rooms where user_id='{$_SESSION["user"]["user_id"]}';";
$res=e_sql($sql,GET_ASSOC);
    echo '<form action="#" method="post">
<input type="text" name="program_name"/>
<select name="room_id">';
foreach ($res as $re)
echo "<option value=\"{$re["room_id"]}\">{$re["room_name"]}</option>";
echo'</select>';
echo '<input type="submit" value="Save"/>
</form>';
}





