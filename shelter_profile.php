<?php

session_start();
include_once('database/connection.php');
include_once('database/shelters.php');
include_once('database/users.php');

$shelter = getShelterByID($_GET['id']);
$pets = getShelterPets($_GET['id']);
$adoption = getShelterPetsForAdoption($_GET['id']);

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/shelter_profile.php');
include('templates/common/footer.php');
