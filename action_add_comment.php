<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');

$pet_id = addPetComment($_GET['pet_id'], $_GET['user_id'], $_GET['text']);

header('Location: pet_detail.php?id=' . $pet_id);
die();