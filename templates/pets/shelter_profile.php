<section class="banner" style="background-image: url('database/images/shelters/header/originals/<?= $shelter['shelter_id'] ?>.jpg');">
    <a><?= $shelter['name'] ?></a>
</section>

<section class="shelter_profile">
    <section class="left">
        <div class="profile_pic"
             style="background-image: url('database/images/shelters/profile/thumbs_medium/<?= $shelter['shelter_id'] ?>.jpg') ">
        </div>
        <div id="about_me">
            <a href="#"><i class="far fa-file"></i>
                <span>About Me</span></a>
        </div>
        <div id="location">
            <a href="#"><i class="fas fa-map-marker-alt"></i>
                <span>Location</span></a>
        </div>
        <div id="contact">
            <a href="#"><i class="fas fa-mobile-alt"></i>
                <span>Contacts</span>
            </a>
        </div>
        <section class="shelter_adoption">
            <div class="title"><i class="fas fa-paw"></i>
                <span>For adoption</span>
            </div>
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
        </section>
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
