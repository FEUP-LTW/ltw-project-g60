<?php
session_start();                         // starts the session

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/pets.php');
include_once('database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

if(isset($_POST['id'])) {
    removeFavoritePet($_POST['id']);
}

die();