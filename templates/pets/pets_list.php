<section class="search">
    <form action="./pets_list.php" method="GET">
        <div id="search-wrap">
            <div id="search">
                <input type="text" autocomplete="off" name="search" placeholder="search for a pet..">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
        </div>

        <select name="category">
            <option value="" disabled selected>Category</option>
            <option value="">option 1</option>
        </select>
        <select name="gender">
            <option value="" disabled selected>Gender</option>
            <option value="">option 1</option>
        </select>
        <select name="color">
            <option value="" disabled selected>Color</option>
            <option value="">option 1</option>
        </select>
        <select name="age">
            <option value="" disabled selected>Age</option>
            <option value="">option 1</option>
        </select>
        <label>Favorites
            <input type="checkbox" name="favorites">
        </label>

    </form>
</section>

<section class="pets-list">
    <?php
        foreach ($pets as $pet) { ?>
            <article class="pet-card">
                <a class="pet-image" href="pet_detail.php?id=<?= $pet['pet_id'] ?>"><img src="https://picsum.photos/200" alt="pet photo"></a>
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
                    <a class="button" href="#">Add to Favorites</a>
                    <a class="button" href="#">View Owner</a>
                    <a class="button" href="pet_detail.php?id=<?= $pet['pet_id'] ?>">Details</a>
                </div>
            </article>
            <hr>
        <?php } ?>
</section>
