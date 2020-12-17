<?php
session_start();                         // starts the session

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table
include_once('database/upload.php');

if (!isset($_SESSION['csrf']) || $_SESSION['csrf'] !== $_POST['csrf']){
  echo '<script type="text/javascript">alert("Hacker Attack")</script>';
  die();
}

$stringpattern = "/[^a-zA-Z àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ]/";
$name = preg_replace($stringpattern, '', $_POST['name']);
$username = preg_replace($stringpattern, '', $_POST['username']);
if ((strcmp($_POST['usertype'], "user") !==0) and (strcmp($_POST['usertype'], "shelter") !==0))
    $usertype = "user";


if (userExists($_POST['username'])) {  // test if user exists
    header('Location: register.php');
} else {
    registerUser($_POST['name'], $_POST['username'], $_POST['password'], $_POST['usertype'], $_FILES['profile_photo'], $_FILES['header_photo']);
    $_SESSION['username'] = $_POST['username'];            // store the username
    header('Location: homepage.php');
}

die();
