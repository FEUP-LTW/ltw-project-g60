<?php
session_start();
set_csrf();

include_once('database/connection.php'); // connects to the database
include_once('database/users.php');      // loads the functions responsible for the users table

if (isset($_SESSION['username'])) {
    $username = $_SESSION['username'];
    $uID = getUserByUsername($username);
    if (isUser($_SESSION['username'])) {
        $favs = getUserFavorites(strval($uID['user_id']));
        echo json_encode($favs);
    }else{
        echo json_encode([]);
    }
}
