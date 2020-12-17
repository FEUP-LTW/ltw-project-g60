<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/upload.php');

editUser($_POST['name'], $_POST['username'], $_POST['password'], "shelter", $_FILES['profile_photo'], $_FILES['header_photo'], null);

$_SESSION['username'] = $_POST['username'];            // store the username
header('Location: ' . $_SERVER['HTTP_REFERER']);

die();