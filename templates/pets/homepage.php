<div class="content">
    <div class="cards" id="homepage-cards">
        <div class="card">
            <a href="pet_detail.php?id=<?= $pets[0]['pet_id'] ?>">
                <div class="card-title">Featured Pet</div>
                <div class="image"
                    style="background-image: url('database/images/pets/originals/<?= getImageByPetId($pets[0]['pet_id']) ?>.jpg">
                </div>
                <div class="container">
                    <h4><b><?= $pets[0]['name'] ?></b></h4>
                    <p><?= $pets[0]['info'] ?></p>
                </div>
            </a>
        </div>
        <div class="card">
            <a href="shelter_profile.php?id=<?=$shelter['shelter_id'] ?>">
                <div class="card-title">Featured Shelter</div>
                <div class="image"
                     style="background-image: url('database/images/shelters/profile/originals/<?= $shelter['shelter_id'] ?>.jpg">
                </div>
                <div class="container">
                    <h4><b><?= $shelter['name'] ?></b></h4>
                    <p><?= $shelter['info'] ?></p>
                </div>
            </a>
        </div>
        <div class="card">
            <a href="pet_detail.php?id=<?= $pets[1]['pet_id'] ?>">
                <div class="card-title">Featured Pet</div>
                <div class="image"
                     style="background-image: url('database/images/pets/originals/<?= getImageByPetId($pets[1]['pet_id']) ?>.jpg">
                </div>
                <div class="container">
                    <h4><b><?= $pets[1]['name'] ?></b></h4>
                    <p><?= $pets[1]['info'] ?></p>
                </div>
            </a>
        </div>
    </div>
    <div id="shuffle-button">
        <a href="pet_detail.php?id=<?=$allpets[array_rand($allpets)]['pet_id']?>" >
            <div class="button">Adopt your future Pet</div>
        </a>
    </div>
</div>