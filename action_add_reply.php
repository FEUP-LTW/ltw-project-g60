<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');

$comment_id = addPetReply($_GET['comment_id'], $_GET['text'], $_GET['user_id'], $_GET['type']);

die();