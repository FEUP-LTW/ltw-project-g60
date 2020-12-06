<section class="banner" style="background-image: url('https://images.unsplash.com/photo-1570021974424-60e83dfee639?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80');">
    <a><?= $shelter['name'] ?></a>
</section>

<section class="shelter_profile">
    <section class="left">
        <div class="profile_pic">
            <img src="https://picsum.photos/200/200" alt="shelter photo">
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
                        <img src="<?= $pet['imagePath'] ?>" alt="puppy photo">
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
                        <img src="<?= $pet['imagePath'] ?>" alt="puppy photo" >
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
