<?php
session_start();                         // starts the session

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

editUser($_POST['name'], $_POST['username'], $_POST['password'], "shelter", $_FILES['profile_photo'], $_FILES['header_photo'], null);

$_SESSION['username'] = $_POST['username'];            // store the username
header('Location: ' . $_SERVER['HTTP_REFERER']);

die();