<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/pets.php');

addPet(getSessionId(),$_POST['name'],$_FILES['photo'],$_POST['breed'],$_POST['size'],$_POST['color'],$_POST['gender'],
    $_POST['information'],$_POST['age'],$_POST['location']);

header('Location: ' . 'homepage.php');
die();