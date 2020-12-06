<section class="navigation_bar">
    <a href="homepage.php">Adoption Center</a>
    <nav id="links">
        <a href="pets_list.php">Pets</a>
        <a href="shelters_list.php">Shelters</a>
    </nav>
    <nav id="signup">
        <?php if (!isset($_SESSION['username'])) { ?>
            <a href="register.php">Register</a>
            <a href="login.php">Login</a>
        <?php } else { ?>
            <a href="pet_add.php">Add Pet</a>
            <a href=""><?= getUserByUsername($_SESSION['username'])['name'] ?></a>
            <a href="action_logout.php">Logout</a>
        <?php } ?>
    </nav>
</section>