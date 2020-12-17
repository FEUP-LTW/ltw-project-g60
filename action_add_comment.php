<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');

if (isset($_GET['text']) && isset($_GET['user_id'])) {
    $pet_id = addPetComment($_GET['pet_id'], $_GET['user_id'], $_GET['text']);
}

// Get last_id
$last_id = $_GET['last_id'];
$pet_id = $_GET['pet_id'];

global $db;
// Retrieve new messages
$stmt = $db->prepare("SELECT * FROM Comments, Users
                    WHERE Comments.id > :last_id AND pet_id = :pet_id AND Comments.user_id = Users.user_id
                    ORDER BY date DESC");
$stmt->bindParam(':last_id', $last_id);
$stmt->bindParam(':pet_id', $pet_id);
$stmt->execute();
$comments = $stmt->fetchAll();

$comments = array_reverse($comments);

// Add a time field to each message
foreach ($comments as $index => $comment) {
    $time = date("Y-m-d H:i", substr($comment['date'], 0, 10));
    $comments[$index]['time'] = $time;
}

// JSON encode
echo json_encode($comments);

die();