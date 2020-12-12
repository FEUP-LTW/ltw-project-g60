<div class="page-content" id="pet-profile">
    <div class="pet-bio">
        <a class="pet-image" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($pet['pet_id']) ?>.jpg')">
        </a>
        <section class="pet-info">
            <div id="title">
                <h2><?= $pet['name'] ?></h2>
                <span><?= $pet['state'] ?></span>
            </div>
            <div id="pet-details">
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
            <p><?= $pet['info'] ?></p>
        </section>
        <?php
        $owner = getPetOwner($pet['pet_id']);
        if ($owner[1] == 'user') {
            echo '<a id="owner-info" href="user_profile.php?id=' . $owner[0] . '">';
            echo "<div class=\"img\" style=\"background-image: url('database/images/users/profile/thumbs_medium/" . $owner[0] . ".jpg')\"> </div>
                  <p>" . getUserByID($owner[0])['name'] . '</p>
                  </a>';
        }
        else {
            echo '<a id="owner-info" href="shelter_profile.php?id=' . $owner[0] . '">';
            echo "<div class=\"img\" style=\"background-image: url('database/images/shelters/profile/thumbs_medium/" . $owner[0] . ".jpg')\"></div>
                  <p>" . getShelterByID($owner[0])['name'] . '</p>
                  </a>';
        }
        ?>
    </div>
    <section id="options">
        <h2>Options</h2>
        <div class="buttons">
            <a href="#" class="button">Submit Proposal</a>
            <a href="#" class="button">Add to Favorites</a>
        </div>
    </section>
    <section id="proposals">
        <h2>Proposals</h2>
        <div class="grid-list">
            <?php foreach ($proposals as $proposal) { ?>
                <article class="adoption-proposal">
                    <div class="img" style="background-image: url('database/images/users/profile/thumbs_medium/<?= $proposal['user_id'] ?>.jpg"></div>
                    <h3><?= $proposal['name'] ?></h3>
                    <div class="user-details">
                        <p><?= $proposal['info'] ?></p>
                        <small><?= date("Y-m-d H:i", substr($proposal['date'], 0, 10)) ?></small>
                        <a href="user_profile.php?id=<?= $proposal['user_id'] ?>" class="button">View User</a>
                    </div>
                </article>
            <?php } ?>
        </div>
    </section>
    <section id="pet-comments">
        <h2><?= count($comments) ?> Comments</h2>
        <?php foreach ($comments as $comment) { ?>
            <div class="pet-comment">
                <a href="user_profile.php?id=<?= $comment['user_id'] ?>" class="user-image" style="background-image: url('database/images/users/profile/thumbs_medium/<?= $comment['user_id'] ?>.jpg')"></a>
                <span class="user"><a href="user_profile.php?id=<?= $comment['user_id'] ?>"><?= $comment['name'] ?></a></span>
                <span class="date"><?= date("Y-m-d H:i", substr($comment['date'], 0, 10)) ?></span>
                <p><?= $comment['text'] ?></p>
            </div>
        <?php } ?>
        <?php if (isset($_SESSION['username']) and isUser(getUserByUsername($_SESSION['username'])['user_id'])) { ?>
        <form action="action_add_comment.php" method="get" class="add-comment">
            <label for="text">Add a Comment on This Pet</label>
            <textarea id="text" name="text" placeholder="Comment" required></textarea>
            <label for="user_id" hidden></label>
            <input id="user_id" name="user_id" type="text" hidden value="<?= getUserByUsername($_SESSION['username'])['user_id'] ?>">
            <label for="pet_id" hidden></label>
            <input id="pet_id" name="pet_id" type="text" hidden value="<?= $_GET['id'] ?>">
            <input type="submit" class="button" value="Submit">
        </form>
        <?php } ?>
    </section>
</div>