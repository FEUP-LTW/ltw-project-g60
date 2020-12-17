<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

if (userPasswordExists($_POST['username'], $_POST['password'])) {  // test if user exists
    $_SESSION['username'] = $_POST['username'];            // store the username
}

header('Location: ' . 'homepage.php');
die();