<section class="search" style="background-image: url('res/banner.jpg')">
    <form action="shelters_list.php" method="GET">
        <div id="search-wrap">
            <div id="search">
                <input type="text" autocomplete="off" name="search" placeholder="search for a shelter...">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
        </div>
    </form>
</section>
<section class="shelters-list">
    <?php foreach ($shelters as $shelter) { ?>
        <article class="shelter-card">
            <a class="shelter-image" href="shelter_profile.php?id=<?= $shelter['shelter_id'] ?>" style="background-image: url('database/images/shelters/profile/thumbs_medium/<?= $shelter['shelter_id'] ?>.jpg')"></a>
            <div class="pet-information">
                <h1><?= $shelter['name'] ?></h1>
                <div class="no-pets pet-proposals">
                    <p><strong class="pets-number"><?= count(getShelterPets($shelter['shelter_id'])) ?></strong> Pets</p>
                </div>
            </div>
            <div class="shelter-link">
                <a class="button" href="shelter_profile.php?id=<?= $shelter['shelter_id'] ?>">View Shelter</a>
            </div>
        </article>
        <hr>
    <?php } ?>
</section>