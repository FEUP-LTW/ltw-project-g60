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
            <a href="<?php
            $id = getSessionId();
            if (getUserByUsername($_SESSION['username'])) {
                echo "user_profile.php?id=" . $id;
            } else {
                echo "shelter_profile.php?id=" . $id;
            }?>"><?php
                $id = getSessionId();
                if (getUserByUsername($_SESSION['username'])) {
                    echo getUserByUsername($_SESSION['username'])['name'];
                } else {
                    echo getShelterByUsername($_SESSION['username'])['name'];
                }?></a>
            <a href="action_logout.php">Logout</a>
        <?php } ?>
    </nav>
</section>

<script src="scripts/hamburger.js">
</script>
<div class="hamburger_navbar">
    <div id="myLinks">
        <a href="pets_list.php">Pets</a>
        <a href="shelters_list.php">Shelters</a>
        <a href="pet_add.php">Add Pet</a>
        <?php if (!isset($_SESSION['username'])) { ?>
            <a href="register.php">Register</a>
            <a href="login.php">Login</a>
        <?php } else { ?>
        <a href="<?php
        $id = getSessionId();
        if (getUserByUsername($_SESSION['username'])) {
            echo "user_profile.php?id=" . $id;
        } else {
            echo "shelter_profile.php?id=" . $id;
        }?>"><?php
            $id = getSessionId();
            if (getUserByUsername($_SESSION['username'])) {
                echo getUserByUsername($_SESSION['username'])['name'];
            } else {
                echo getShelterByUsername($_SESSION['username'])['name'];
            }?></a>
        <a href="action_logout.php">Logout</a>
        <?php } ?>
    </div>
    <a href="javascript:void(0);" class="icon_navbar" onclick="myFunction()">
        <i class="fa fa-bars"></i>
    </a>
</div>
