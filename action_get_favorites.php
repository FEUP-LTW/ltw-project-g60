<?php
session_start();
include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table

$username = $_SESSION['username'];
$uID = getUserByUsername($username);
$favs = getUserFavorites(strval($uID['user_id']));
echo json_encode($favs);
