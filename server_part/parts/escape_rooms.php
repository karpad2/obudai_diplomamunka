<h3>Escape rooms:</h3>

    <?php
    echo '<table class="table">
    <thead>
    <tr> 
      <th scope="col">#</th>
      
    </tr>
    </thead>';
    //include "../config.php";
    $sql = "select * from escape_rooms where user_id='{$_SESSION["user"]["user_id"]}'";
    $result=e_sql($sql);
    if($result->num_rows>0)
    {
        $res=mysqli_fetch_all($result,0);
        foreach ($res as $re)
        {
            echo "<li class=\"list-group-item d-flex justify-content-between align-items-center\">
        {$re["room_name"]}
    <span class=\"badge bg-primary rounded-pill\">14</span></li>";
        }
    }
    else
    {
        echo "<a href=\"#\" class=\"list-group-item list-group-item-action\">You don't have any program yet.</a>";
    }
    echo '   <a href="index.php?mod=escape_rooms&new" class="list-group-item list-group-item-action active">Click here to add a Rooms.</a>
</table>';

    ?>

