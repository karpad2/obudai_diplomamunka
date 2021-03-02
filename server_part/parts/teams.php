<?php
if(isset($_GET["ajax"]))
{
include "../config.php";
$sql="select teams_name from teams";
$res=e_sql($sql,GET_ASSOC);
foreach ($res as $re)
{
    echo "<a href='#' class='text-dark'>{$re["teams_name"]}</a><br/>";
}
}
else {
    echo "<table class=\"table\">
    <thead>
    <tr>
        <th scope=\"col\">#</th>
        <th scope=\"col\">Teams name:</th>
        <th scope=\"col\">Time:</th>
        <th scope=\"col\">Room Name:</th>
    </tr>
    </thead>";
    echo "<tbody>";
    $sql = "select * from finished_runs";
    $res = e_sql($sql);
    $i = 1;
    foreach ($res as $re) {
        echo "<tr>
        <th scope=\"row\">{$i}</th>
        <td>{$re["teams_name"]}</td>
        <td>{$re["room_name"]}</td>
        <td>@mdo</td>
    </tr>";
        $i++;
    }
    echo "</tbody>";
    echo "</table>";
}

