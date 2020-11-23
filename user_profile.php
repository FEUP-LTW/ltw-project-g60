<?php
session_start();
include_once('database/connection.php');
include_once('database/pets.php');
include_once('database/users.php');

$user = getUserByID($_GET['id']);
$pets = getUserPets($_GET['id']);
// $activity = getUserActivity($_GET['id]);
$collaborations = getUserCollaborations($_GET['id']);

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/user_profile.php');
include('templates/common/footer.php');