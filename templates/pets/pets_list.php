<section class="search" style="background-image: url('res/banner.jpg')">
    <form>
        <div id="search-wrap">
            <div id="search">
                <input id="search_input" type="text" autocomplete="off" name="search" placeholder="search for a pet..">
            </div>
        </div>

        <select id="choice" name="category">
            <option value="" selected>--Breed--</option>
            <?php
            foreach ($breeds as $breed){
            ?>
            <option value="<?=$breed?>"><?=$breed?></option>
            <?php } ?>
        </select>
        <select id="choice" name="gender">
            <option value="" selected>--Gender--</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
        </select>
        <select id="choice" name="color">
            <option value="" selected>--Color--</option>
            <?php
            foreach ($colors as $color){
            ?>
            <option value="<?=$color?>"><?=$color?></option>
            <?php } ?>
        </select>
        <select id="choice" name="age">
            <option value=""  selected>--Age--</option>
            <?php
            for ($x = 0; $x <= 10; $x++) { ?>
                <option value="<?=$x?>"><?=$x?> Years</option>
            <?php } ?>
        </select>
        <label>Favorites
            <input id="choice" type="checkbox" name="favorites">
        </label>

    </form>
</section>

<section class="pets-list">
    <?php
        $index=-1;
        foreach ($pets as $pet) { $index++; ?>
            <article class="pet-card" data-petid="<?=$pet['pet_id'] ?>" >
                <a class="pet-image" href="pet_detail.php?id=<?= $pet['pet_id'] ?>" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg')"></a>
                <div class="pet-information">
                    <h1><?= $pet['name'] ?></h1>
                    <div class="pet-details">
                        <?php
                            if ($pet['gender'] == 0)
                                echo '<i class="fas fa-mars"></i>';
                            else
                                echo '<i class="fas fa-venus"></i>';
                        ?>
                        <span><?= $pet['color'] ?></span>
                        <span><?= $pet['size'] ?>m</span>
                        <span><?= $pet['species'] ?></span>
                        <span><?= $pet['age'] . ' years' ?></span>
                    </div>
                    <div class="pet-proposals">
                        <p><strong><?= getNumberOfProposals($pet['pet_id']) ?></strong> Proposals</p>
                    </div>
                </div>
                <div class="pet-links">
                    <?php if (isset($_SESSION['username']) and isUser($_SESSION['username']) and !isOwner($pet['pet_id'])) { ?>
                    <div class="buttons" >
                        <?php if (!isFavorite($pet['pet_id']) ) { ?>
                            <button id="pet_add_favorite_button" name="favorite" data-index="<?= $index ?>" data-petid="<?= $pet['pet_id'] ?>">Add to Favorites</button>
                        <?php } else { ?>
                            <button id="pet_remove_favorite_button" name="favorite" data-index="<?= $index ?>" data-petid="<?= $pet['pet_id'] ?>">Remove Favorite</button>
                        <?php } ?>
                    </div>
                    <?php } ?>
                    <?php
                        $owner = getPetOwner($pet['pet_id']);
                        if ($owner[1] == 'user')
                            echo '<a class="button" href="user_profile.php?id=' . $owner[0] . '">View Owner</a>';
                        else
                            echo '<a class="button" href="shelter_profile.php?id=' . $owner[0] . '">View Owner</a>';
                    ?>
                    <a class="button" href="pet_detail.php?id=<?= $pet['pet_id'] ?>">Details</a>
                </div>
            </article>
            <hr>
        <?php } ?>
</section>
