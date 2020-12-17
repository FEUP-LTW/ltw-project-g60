<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');
include_once('database/pets.php');
include_once('database/upload.php');

addProposal($_GET['info'],$_GET['user_id'],$_GET['pet_id']);

header('Location: ' . $_SERVER['HTTP_REFERER']);
die();