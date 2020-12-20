<?php
session_start();                         // starts the session

include_once('../database/users.php');      // loads the functions responsible for the users table
include_once('../database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

if (isset($_POST['new-collab'])) {
    editUser($_POST['name'], $_POST['username'], $_POST['password'], "user", $_FILES['profile_photo'], $_FILES['header_photo'], $_POST['new-collab']);
}else{
    editUser($_POST['name'], $_POST['username'], $_POST['password'], "user", $_FILES['profile_photo'], $_FILES['header_photo'], []); //no new collaborations
}
$_SESSION['username'] = $_POST['username'];            // store the username
header('Location: ' . $_SERVER['HTTP_REFERER']);

die();
