

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