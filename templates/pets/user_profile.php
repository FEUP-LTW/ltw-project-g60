<section class="banner"
         style="background-image: url('database/images/users/header/originals/<?= $user['user_id'] ?>.jpg');">
    <a><?= $user['name'] ?></a>
</section>

<section class="user_profile">

    <section class="left">
        <div class="profile_pic"
             style="background-image: url('database/images/users/profile/thumbs_medium/<?= $user['user_id'] ?>.jpg') ">
        </div>
        <?php if (isset($_SESSION['username']) and getUserByID($_GET['id'])['username'] == $_SESSION['username']) { ?>
        <div id="about_me">
            <label><i id="abt_icon" class="far fa-file"></i>
                <span>About Me</span>
                <input id="about_me_check" type="checkbox" name="aboutme" onclick="editUserInfo()">
            </label>
        </div>
        <?php } ?>
        <!--Estando a checkbox ativada ou não mostra os favoritos, evita dar reload á pagina-->
        <div id="favorites">
            <label><i id="fav_icon" class="far fa-heart"></i>
                <span>Favorites</span>
                <input id="user_fav" type="checkbox" name="favorites">
            </label>
        </div>

        <div class="user_pets">
            <div class="title"><i class="fas fa-paw"></i>
                <span>My pets</span></div>
            <div class="pets_container">
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
        </div>
        <div class="user_favorites" style="display: none">
            <div class="title"><i class="fas fa-heart"></i>
                <span>Favorites</span></div>
            <div class="pets_container">
                <?php foreach ($favorites as $pet) { ?>
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
        </div>
        <div class="edit_user_info" style="display: none">
            <div class="title">
                <i class="fas fa-file"></i>
                <span>Edit Info</span>
                <form action="actions/action_edit_user.php" method="post" enctype="multipart/form-data">
                    <input id="csrf_var" type="hidden" name="csrf" value="<?=$_SESSION['csrf']?>">
                    <div class="group">
                        <input id="name" name="name" type="text" value="<?= $user['name'] ?>" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="name">Full Name</label>
                    </div>
                    <div class="group">
                        <input id="username" name="username" value="<?= $user['username'] ?>" type="text" required>
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
                        <input id="password" name="password" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
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
                    <div class="new-collaboration">
                        <div class="new_collabs"> <i class="fas fa-hands-helping"></i>
                            New Collaborations</div>
                        <?php foreach (getSheltersWithoutUserCollaboration($user['user_id']) as $shelter) { ?>
                            <label class="container"><?= $shelter['name'] ?>
                                <input type="checkbox" name="new-collab[]" value="<?= $shelter['shelter_id'] ?>">
                                <div class="checkmark"></div>
                            </label>
                        <?php } ?>
                    </div>
                    <input type="submit" class="button" value="Confirm">
                </form>
            </div>
        </div>
    </section>
    <section class="right">
        <div class="collaborations">
            <div class="title"> <i class="fas fa-hands-helping"></i>
                <span>Collaborations</span></div>

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
                            <p><?= $act['text'] ?></p>
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