<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/pets.php');
include_once('database/upload.php');

console_log($_GET['id']);
if(isset($_GET['id'])) {

    addFavoritePet($_GET['id']);
}

die();