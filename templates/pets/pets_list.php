<section class="search" style="background-image: url('res/banner.jpg')">
    <form action="./pets_list.php" method="GET">
        <div id="search-wrap">
            <div id="search">
                <input type="text" autocomplete="off" name="search" placeholder="search for a pet..">
                <button type="submit"><i class="fas fa-search"></i></button>
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
        foreach ($pets as $pet) { ?>
            <article class="pet-card" >
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
                        <span><?= $pet['size'] ?></span>
                        <span><?= $pet['species'] ?></span>
                        <span><?= $pet['age'] . ' years' ?></span>
                    </div>
                    <div class="pet-proposals">
                        <p><strong><?= getNumberOfProposals($pet['pet_id']) ?></strong> Proposals</p>
                    </div>
                </div>
                <div class="pet-links">
                    <?php
                    if (!empty($_SESSION) and isUser($_SESSION['username'])) { ?>
                    <button id="pet_favorite_button" name="favorite" data-petid="<?= $pet['pet_id'] ?>">Add to Favorites</button>
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
