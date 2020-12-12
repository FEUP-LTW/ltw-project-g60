<section class="banner"
         style="background-image: url('database/images/users/header/originals/<?= $user['user_id'] ?>.jpg');">
    <a><?= $user['name'] ?></a>
</section>

<section class="user_profile">

    <section class="left">
        <div class="profile_pic"
             style="background-image: url('database/images/users/profile/thumbs_medium/<?= $user['user_id'] ?>.jpg') ">
        </div>
        <div id="about_me">
            <a href="#"><i class="far fa-file"></i>
                <span>About Me</span></a>
        </div>
        <!--Estando a checkbox ativada ou não mostra os favoritos, evita dar reload á pagina-->
        <div id="favorites">
            <a href="#"><i class="far fa-heart"></i>
                <span>Favorites</span></a>
        </div>
        <div id="contact">
            <a href="#"><i class="fas fa-mobile-alt"></i>
                <span>Contacts</span>
            </a>
        </div>
        <div class="user_pets">
            <div class="title"><i class="fas fa-paw"></i>
                <span>My pets</span></div>
            <?php foreach ($pets as $pet) { ?>
                <div class="pet">
                    <a href="pet_detail.php?id=<?= $pet['PetID'] ?>">
                        <div class="pet-img" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($pet['PetID']) ?>.jpg')"></div>
                        <div class="container-pet">
                            <h4><b><?= $pet['PetName'] ?></b></h4>
                            <p><?= $pet['PetInfo'] ?></p>
                        </div>
                    </a>
                </div>
            <?php } ?>
        </div>
    </section>
    <section class="right">
        <div class="collaborations">
            <div class="title"> <i class="fas fa-hands-helping"></i>
                <span>Colaborations</span></div>

            <div id="collaboration-imgs">
                <?php foreach ($collaborations as $collab) { ?>
                    <a href="shelter_profile.php?id=<?= $collab['shelter_id'] ?>">
                        <div class="collaboration-img" style="background-image: url('database/images/shelters/profile/thumbs_medium/<?= $collab['shelter_id'] ?>.jpg') ">
                        </div>
                    </a>

                <?php } ?>
            </div>
        </div>
        <div class="user_activity">
            <div class="title"><i class="fas fa-comments"></i>
                <span>Activity</span></div>
            <?php $count = 0; foreach ($activity as $act) { ?>
                <div class="activity-card">
                    <a href="pet_detail.php?id=<?= $act['pet_id'] ?>">
                        <div class="activity-img" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($act['pet_id']) ?>.jpg')"></div>
                        <div class="container-activity">
                            <h4><b>Proposal</b></h4>
                            <p> Made a proposal to this dog.</p>
                        </div>
                    </a>
                </div>
            <?php } ?>
        </div>
    </section>
</section>

<!--
<section class="fav_alltime">
    <a href=""><img src="https://picsum.photos/60/60" alt="">Nome do Favorito</a>
</section>

<section class="favorites">
    <a href=""><img src="https://picsum.photos/60/60" alt="">Nome de outro favorito</a>
</section>-->