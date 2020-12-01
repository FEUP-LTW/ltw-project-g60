<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table

if (userExists($_POST['username'], $_POST['password'])) {  // test if user exists
    header('Location: register.php');
} else {
    registerUser($_POST['name'], $_POST['username'], $_POST['password'], $_POST['usertype']);
    $_SESSION['username'] = $_POST['username'];            // store the username
    header('Location: homepage.php');
}

die();
