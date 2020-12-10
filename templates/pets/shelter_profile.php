<section class="banner" style="background-image: url('database/images/shelters/header/originals/<?= $shelter['shelter_id'] ?>.jpg');">
    <a><?= $shelter['name'] ?></a>
</section>

<section class="shelter_profile">
    <section class="left">
        <div class="profile_pic"
             style="background-image: url('database/images/shelters/profile/thumbs_medium/<?= $shelter['shelter_id'] ?>.jpg') ">
        </div>
        <div id="about_me">
            <a href="#"><i class="far fa-file"></i>About Us</a>
        </div>
        <div id="location">
            <a href="#"><i class="fas fa-map-marker-alt"></i>Location</a>
        </div>
        <div id="contact">
            <a href="#"><i class="fas fa-mobile-alt"></i>Contacts</a>
        </div>
        <section class="shelter_adoption">
            <div class="title">For adoption</div>
            <?php foreach ($adoption as $pet) { ?>
                <div class="adoption-card">
                    <a href="pet_detail.php?id=<?= $pet['pet_id'] ?>">
                        <img src="database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg" alt="puppy photo">
                        <div class="container-dog">
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
            <div class="title">Adopted</div>
            <?php foreach ($pets as $pet) { ?>
                <div class="adopted-card">
                    <a href="pet_detail.php?id=<?= $pet['pet_id'] ?>">
                        <img src="database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg" alt="puppy photo" >
                        <div class="container-dog">
                            <h4><b><?= $pet['name'] ?></b></h4>
                            <p><?= $pet['info'] ?></p>
                        </div>
                    </a>
                </div>
            <?php } ?>
        </div>
    </section>
</section>
