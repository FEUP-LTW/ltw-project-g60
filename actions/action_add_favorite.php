<?php
session_start();                         // starts the session

include_once('../database/users.php');      // loads the functions responsible for the users table
include_once('../database/pets.php');
include_once('../database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

console_log($_POST['id']);
if(isset($_POST['id'])) {
  addFavoritePet($_POST['id']);
}

die();