<div class="page-content" id="pet-profile" >
    <div class="pet-bio">
        <a class="pet-image" style="background-image: url('database/images/pets/thumbs_medium/<?= getImageByPetId($_GET['id']) ?>.jpg')">
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
            <?php
            if (isset($_SESSION['username'])) {
                if ($owner[1] == 'user') {
                    if (getUserByID($owner[0])['username'] == $_SESSION['username'])
                        echo '<a href="pet_edit.php?id=' . $pet['pet_id'] . '" class="button" id="edit-pet-button">Edit Post</a>';
                } else {
                    if (getShelterByID($owner[0])['username'] == $_SESSION['username'])
                        echo '<a href="pet_edit.php?id=' . $pet['pet_id'] . '" class="button" id="edit-pet-button">Edit Post</a>';
                }
            }
            ?>

        </section>
        <?php
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
    <?php if (isset($_SESSION['username']) and isUser($_SESSION['username'])) { ?>
    <section id="options">
        <h2>Options</h2>
        <div class="buttons">
            <button id="pet_proposal_button" name="proposal" >Submit Proposal</button>
            <?php if (!isFavorite($_GET['id'])) { ?>
            <button id="pet_add_favorite_button" name="favorite" data-index="0" data-petid="<?= $_GET['id'] ?>">Add to Favorites</button>
            <?php } else { ?>
            <button id="pet_remove_favorite_button" name="favorite" data-index="0" data-petid="<?= $_GET['id'] ?>">Remove Favorite</button>
            <?php } ?>
        </div>
    </section>
    <?php } ?>
    <section id="proposals">
        <h2>Proposals</h2>
        <div class="grid-list">
            <?php foreach ($proposals as $proposal) { ?>
                <article class="adoption-proposal">
                    <div class="img" style="background-image: url('database/images/users/profile/thumbs_medium/<?= $proposal['user_id'] ?>.jpg"></div>
                    <h3><?= $proposal['name'] ?></h3>
                    <div class="user-details">
                        <p><?= $proposal['text'] ?></p>
                        <small><?= date("Y-m-d H:i", substr($proposal['date'], 0, 10)) ?></small>
                        <a href="user_profile.php?id=<?= $proposal['user_id'] ?>" class="button">View User</a>
                    </div>
                </article>
            <?php } ?>
        </div>
    </section>
    <?php if (isset($_SESSION['username']) and isUser($_SESSION['username'])) { ?>
    <section id="make_proposal" style="display: none">
        <h2>Submit Proposal</h2>
        <form action="action_submit_proposal.php" method="get">
            <label>Description
                <textarea id="info" name="info" placeholder="Describe your proposal" required></textarea>
            </label>
            <label for="user_id" hidden></label>
            <input id="user_id" name="user_id" type="text" hidden value="<?= getUserByUsername($_SESSION['username'])['user_id'] ?>">
            <label for="pet_id" hidden></label>
            <input id="pet_id" name="pet_id" type="text" hidden value="<?= $_GET['id'] ?>">
            <input hidden type="submit" class="button">
        </form>
    </section>
    <?php } ?>
    <section id="pet-comments">
        <h2><?= count($comments) ?> Comments</h2>
        <div id="overlay">
            <div>
                <form id="add-reply">
                    <label for="reply-text">Reply</label>
                    <textarea id="reply-text" name="reply-text" placeholder="Comment" required></textarea>
                    <label for="reply-user_id" hidden></label>
                    <?php
                    if (isUser($_SESSION['username'])) echo '<input id="reply-user_id" name="reply-user_id" type="text" hidden value="' . getUserByUsername($_SESSION['username'])['user_id'] . '">';
                    else echo '<input id="reply-user_id" name="reply-user_id" type="text" hidden value="' . getShelterByUsername($_SESSION['username'])['shelter_id'] . '">';
                    ?>
                    <label for="reply-type" hidden></label>
                    <?php
                    if (isUser($_SESSION['username'])) echo '<input id="reply-type" name="reply-type" type="text" hidden value="user">';
                    else echo '<input id="reply-type" name="reply-type" type="text" hidden value="shelter">';
                    ?>
                    <input type="submit" class="button" value="Submit">
                </form>
            </div>
        </div>
        <?php foreach ($comments as $comment) { ?>
            <div class="pet-comment">
                <a href="user_profile.php?id=<?= $comment['user_id'] ?>" class="user-image" style="background-image: url('database/images/users/profile/thumbs_medium/<?= $comment['user_id'] ?>.jpg')"></a>
                <span class="user"><a href="user_profile.php?id=<?= $comment['user_id'] ?>"><?= $comment['name'] ?></a></span>
                <span class="date"><?= date("Y-m-d H:i", substr($comment['date'], 0, 10)) ?></span>
                <p><?= $comment['text'] ?></p>
                <?php if (isset($_SESSION['username']))
                    echo '<span class="reply-button button" data-comment-id="' . $comment['id'] . '">Reply</span>'?>
            </div>
            <?php
            $replies = getCommentReplies($comment['id']);
            foreach ($replies as $reply) {
                if ($reply['type'] == "user") {
                    echo '<div class="pet-answer">';
                    echo "<a href=\"user_profile.php?id=" . $reply['user_id'] . "\" class=\"user-image\" style=\"background-image: url('database/images/users/profile/thumbs_medium/" . $reply['user_id'] . ".jpg')\"></a>";
                    echo "<span class=\"user\"><a href=\"user_profile.php?id=" . $reply['user_id'] . "\">" . getUserByID($reply['user_id'])['name'] . "</a></span>";
                    echo "<span class=\"date\">" . date("Y-m-d H:i", substr($reply['date'], 0, 10)) . "</span>";
                    echo "<p>" . $reply['text'] . "</p>";
                    echo "</div>";
                }
                else {
                    echo '<div class="pet-answer">';
                    echo "<a href=\"shelter_profile.php?id=" . $reply['user_id'] . "\" class=\"user-image\" style=\"background-image: url('database/images/shelters/profile/thumbs_medium/" . $reply['user_id'] . ".jpg')\"></a>";
                    echo "<span class=\"user\"><a href=\"shelter_profile.php?id=" . $reply['user_id'] . "\">" . getShelterByID($reply['user_id'])['name'] . "</a></span>";
                    echo "<span class=\"date\">" . date("Y-m-d H:i", substr($reply['date'], 0, 10)) . "</span>";
                    echo "<p>" . $reply['text'] . "</p>";
                    echo "</div>";
                }
            }
            ?>
        <?php } ?>
        <?php if (isset($_SESSION['username']) and isUser($_SESSION['username'])) { ?>
        <form id="add-comment">
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