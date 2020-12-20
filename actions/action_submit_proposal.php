<?php
session_start();                         // starts the session

include_once('../database/users.php');
include_once('../database/pets.php');
include_once('../database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

addProposal($_POST['info'],$_POST['user_id'],$_POST['pet_id']);

header('Location: ' . $_SERVER['HTTP_REFERER']);
die();