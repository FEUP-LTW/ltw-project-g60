<?php
session_start();                         // starts the session
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/pets.php');
include_once('database/upload.php');

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
  addPet($_SESSION['username'],$name,$_FILES['photo'], $breed,$size,$color,$gender,
      $information,$age,$location, $_POST['state']);

  header('Location: ' . 'homepage.php');
  die();
} else {
  header('Location: ' . 'pet_add.php');
  die();
}

