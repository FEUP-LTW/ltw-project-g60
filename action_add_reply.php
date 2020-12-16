<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');
include_once('database/shelters.php');
include_once('database/users.php');

if (isset($_GET['text']) && isset($_GET['user_id'])) {
    $comment_id = addPetReply($_GET['comment_id'], $_GET['text'], $_GET['user_id'], $_GET['type']);
}

// Get last_id
$last_id = $_GET['last_id'];

global $db;
$stmt = $db->prepare('SELECT * FROM Answers WHERE comment_id = :id AND Answers.id > :last_id');
$stmt->bindParam(':id', $_GET['comment_id']);
$stmt->bindParam(':last_id', $last_id);
$stmt->execute();
$answers = $stmt->fetchAll();

// Add a time field to each message
foreach ($answers as $index => $answer) {
    $time = date("Y-m-d H:i", substr($answer['date'], 0, 10));
    $answers[$index]['time'] = $time;
    if ($answer['type'] == "user"){
        $answers[$index]['name'] = getUserByID($answer['user_id'])['name'];
    }else{
        $answers[$index]['name'] = getShelterByID($answer['user_id'])['name'];
    }
}

// JSON encode
echo json_encode($answers);

die();