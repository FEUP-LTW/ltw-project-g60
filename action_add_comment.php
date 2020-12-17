<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');

$pet_id = addPetComment($_GET['pet_id'], $_GET['user_id'], $_GET['text']);

die();