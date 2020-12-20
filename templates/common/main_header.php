<header id="main-header" class="header" style="background-image: url('../res/banner.jpg')">
    <a href="../adoptionCenter/homepage.php">
        <h1>Adoption Center</h1>
    </a>
    <h2>A center to adopt</h2>
    <nav id="links">
        <a href="../adoptionCenter/pets_list.php">Pets</a>
        <a href="../adoptionCenter/shelters_list.php">Shelters</a>
    </nav>
    <nav id="signup">
    <?php if (!isset($_SESSION['username'])) { ?>
        <a href="../adoptionCenter/register.php">Register</a>
        <a href="../adoptionCenter/login.php">Login</a>
    <?php } else { ?>
        <a href="../adoptionCenter/pet_add.php">Add Pet</a>
        <a href="<?php
            $id = getSessionId();
            if (getUserByUsername($_SESSION['username'])) {
                echo "../adoptionCenter/user_profile.php?id=" . $id;
            } else {
                echo "../adoptionCenter/shelter_profile.php?id=" . $id;
            }?>"><?php
            $id = getSessionId();
            if (getUserByUsername($_SESSION['username'])) {
                echo getUserByUsername($_SESSION['username'])['name'];
            } else {
                echo getShelterByUsername($_SESSION['username'])['name'];
            }?></a>
        <a href="../actions/action_logout.php">Logout</a>
    <?php } ?>
    </nav>
</header>
<div class="hamburger">
    <!-- Navigation links (hidden by default) -->
    <div id="myLinks">
        <a href="../adoptionCenter/pets_list.php">Pets</a>
        <a href="../adoptionCenter/shelters_list.php">Shelters</a>
        <a href="../adoptionCenter/pet_add.php">Add Pet</a>
        <?php if (!isset($_SESSION['username'])) { ?>
            <a href="../adoptionCenter/register.php">Register</a>
            <a href="../adoptionCenter/login.php">Login</a>
        <?php } else { ?>
            <a href="<?php
            $id = getSessionId();
            if (getUserByUsername($_SESSION['username'])) {
                echo "../adoptionCenter/user_profile.php?id=" . $id;
            } else {
                echo "../adoptionCenter/shelter_profile.php?id=" . $id;
            }?>"><?php
                $id = getSessionId();
                if (getUserByUsername($_SESSION['username'])) {
                    echo getUserByUsername($_SESSION['username'])['name'];
                } else {
                    echo getShelterByUsername($_SESSION['username'])['name'];
                }?></a>
            <a href="../actions/action_logout.php">Logout</a>
        <?php } ?>
    </div>

    <a href="javascript:void(0);" class="icon" onclick="myFunction()">
        <i class="fa fa-bars"></i>
    </a>
</div>