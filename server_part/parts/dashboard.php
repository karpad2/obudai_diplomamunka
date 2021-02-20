<?php ?>
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
    <h1 class="display-4">Escape Rooms</h1>
    <p class="lead">Escape Rooms what you can manage:</p>
  </div>

  <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
      <?php
      $sql="select * from escape_rooms where user_id='{$_SESSION["user"]["user_id"]}'";
      $res=e_sql($sql);
      if($res->num_rows==0)
          $nu=1;
        $res=mysqli_fetch_all($res,MYSQLI_ASSOC);
      foreach ($res as $re)
      {
      echo "<div class=\"col\">
      <div class=\"card mb-4 shadow-sm\">
      <div class=\"card-header\">
        <h4 class=\"my-0 fw-normal\">{$re["room_name"]}</h4>
      </div>
      <div class=\"card-body\">
        <h1 class=\"card-title pricing-card-title\">$0 <small class=\"text-muted\">/ mo</small></h1>
        <ul class=\"list-unstyled mt-3 mb-4\">
          <li>5 device for free</li>
          <li>Email support</li>
          <li>Help center access</li>
          </ul>
        <a href=\"index.php?mod=room&room_id={$re["room_id"]}\" class=\"w-100 btn btn-lg btn-outline-primary\">Escape room create</a>
      </div>
    </div>
    </div>";

      }



      echo '<div class="col">
      <div class="card mb-4 shadow-sm">
      <div class="card-header">
        <h4 class="my-0 fw-normal">Free</h4>
      </div>
      <div class="card-body">
        <h1 class="card-title pricing-card-title">$0 <small class="text-muted">/ mo</small></h1>
        <ul class="list-unstyled mt-3 mb-4">
          <li>5 device for free</li>
          <li>Email support</li>
          <li>Help center access</li>';
         echo isset($nu)?"<li>Create your first escape room here</li>":"";
      echo '</ul>
        <a href="index.php?mod=room&create" class="w-100 btn btn-lg btn-outline-primary">Escape room create</a>
      </div>
    </div>
    </div>'; ?>

  </div>
