<section class="banner" style="background-image: url('database/images/shelters/header/originals/<?= $shelter['shelter_id'] ?>.jpg');">
    <a><?= $shelter['name'] ?></a>
</section>

<section class="shelter_profile">
    <section class="left">
        <div class="profile_pic"
             style="background-image: url('database/images/shelters/profile/thumbs_medium/<?= $shelter['shelter_id'] ?>.jpg') ">
        </div>
        <?php if (isset($_SESSION['username']) and getShelterByID($_GET['id'])['username'] == $_SESSION['username']) { ?>
            <div id="about_me">
                <label><i id="abt_icon" class="far fa-file"></i>
                    <span>About Us</span>
                    <input id="about_me_check" type="checkbox" name="aboutme" onclick="editShelterInfo()">
                </label>
            </div>
        <?php } ?>
        <div id="location">
            <label ><i class="fas fa-map-marker-alt"></i>
                <span>Location</span></label>
        </div>
        <div id="contact">
            <label><i class="fas fa-mobile-alt"></i>
                <span>Contacts</span>
            </label>
        </div>
        <section class="shelter_adoption">
            <div class="title"><i class="fas fa-paw"></i>
                <span>For adoption</span>
            </div>
            <div class="pets_container">
                <?php foreach ($adoption as $pet) { ?>
                    <div class="adoption-card">
                        <a href="pet_detail.php?id=<?= $pet['pet_id'] ?>">
                            <div class="pet-img" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg')"></div>
                            <div class="container-pet">
                                <h4><b><?= $pet['name'] ?></b></h4>
                                <p><?= $pet['info'] ?></p>
                            </div>
                        </a>
                    </div>
                <?php } ?>
            </div>
        </section>
        <div class="edit_shelter_info" style="display: none">
            <div class="title">
                <i class="fas fa-file"></i>
                <span>Edit Info</span>
                <form action="actions/action_edit_shelter.php" method="post" enctype="multipart/form-data">
                    <input id="csrf_var" type="hidden" name="csrf" value="<?=$_SESSION['csrf']?>">
                    <div class="group">
                        <input id="name" name="name" type="text" value="<?= $shelter['name'] ?>" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="name">Full Name</label>
                    </div>
                    <div class="group">
                        <input id="username" name="username" value="<?= $shelter['username'] ?>" type="text" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="username">Username</label>
                    </div>
                    <div id="photos">
                        <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                            Profile
                            <input hidden type="file" class="button" name="profile_photo">
                        </label>
                        <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                            Header
                            <input hidden type="file" class="button" name="header_photo">
                        </label>
                    </div>
                    <div class="group">
                        <input id="password" name="password" type="password" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="password">Password</label>
                    </div>
                    <div class="group">
                        <input id="confirm-password" name="confirm-password" type="password" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="confirm-password">Confirm Password</label>
                    </div>
                    <input type="submit" class="button" value="Confirm">
                </form>
            </div>
        </div>
    </section>
    <section class="right">
        <div class="shelter_adopted">
            <div class="title"><i class="fas fa-home"></i>
                <span>Adopted</span>
            </div>
            <?php foreach ($pets as $pet) { ?>
                <div class="adopted-card">
                    <a href="pet_detail.php?id=<?= $pet['pet_id'] ?>">
                        <div class="pet-img" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg')"></div>
                        <div class="container-pet">
                            <h4><b><?= $pet['name'] ?></b></h4>
                            <p><?= $pet['info'] ?></p>
                        </div>
                    </a>
                </div>
            <?php } ?>
        </div>
    </section>
</section>
