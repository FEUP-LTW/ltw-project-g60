<?php
session_start();                         // starts the session

include_once('../database/pets.php');
include_once('../database/shelters.php');
include_once('../database/users.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

if (isset($_POST['text']) && isset($_POST['user_id'])) {
    $comment_id = addPetReply($_POST['comment_id'], $_POST['text'], $_POST['user_id'], $_POST['type']);
}

// Get last_id
$last_id = $_POST['last_id'];

global $db;
$stmt = $db->prepare('SELECT * FROM Answers WHERE comment_id = :id AND Answers.id > :last_id');
$stmt->bindParam(':id', $_POST['comment_id']);
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