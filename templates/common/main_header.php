<header id="main-header" class="header">
    <a href="homepage.php">
        <h1>Adoption Center</h1>
    </a>
    <h2>A center to adopt</h2>
    <nav id="links">
        <a href="pets_list.php">Pets</a>
        <a href="shelters_list.php">Shelters</a>
    </nav>
    <nav id="signup">
    <?php if (!isset($_SESSION['username'])) { ?>
        <a href="register.php">Register</a>
        <a href="login.php">Login</a>
    <?php } else { ?>
        <a href=""><?= getUserByUsername($_SESSION['username'])['name'] ?></a>
        <a href="action_logout.php">Logout</a>
    <?php } ?>
    </nav>

</header>