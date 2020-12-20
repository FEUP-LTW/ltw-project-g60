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

$colors = getPetColors();
$breeds = getBreeds();

$stringpattern = "/[^a-zA-Z àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]/";
$name = preg_replace($stringpattern, '', $_POST['name']);
$breed = preg_replace($stringpattern, '', $_POST['breed']);
$color = preg_replace($stringpattern, '', $_POST['color']);
$information = preg_replace($stringpattern, '', $_POST['information']);
$location = preg_replace($stringpattern, '', $_POST['location']);

$numberpattern = "/[^0-9\.]/";
$size = preg_replace($numberpattern, '', $_POST['size']);
$age = preg_replace($numberpattern, '', $_POST['age']);
$gender = preg_replace($numberpattern, '', $_POST['gender']);

if( in_array($_POST['breed'], $breeds) and in_array($_POST['color'], $colors) ){
    editPet($_POST['pet_id'],$name, $_FILES['photo'], $breed, $size, $color, $gender,
        $information,$age,$location, $_POST['state']);

    header('Location: ' . 'pet_detail.php?id=' . $_POST['pet_id']);
    die();
} else {
    header('Location: ' . 'pet_edit.php');
    die();
}