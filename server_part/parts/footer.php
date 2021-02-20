<footer class="pt-4 my-md-5 pt-md-5 border-top">
    <div class="row">
        <div class="col-12 col-md">
            <img class="mb-2" src="media/logo.svg" alt="" width="24" height="19">
            <small class="d-block mb-3 text-muted">karpad2 &copy; <?php echo date("Y"); ?></small>
        </div>
        <div class="col-6 col-md">
            <h5>Features</h5>
           <?php echo get_config_text("features"); ?>
        </div>
        <div class="col-6 col-md">
            <h5>Resources</h5>
            <?php echo get_config_text("resources"); ?>
        </div>
        <div class="col-6 col-md">
            <h5>About</h5>
            <?php echo get_config_text("about_link"); ?>
        </div>
    </div>
</footer>
</main>
<script src="js/script.js"></script>
</body>
</html>
