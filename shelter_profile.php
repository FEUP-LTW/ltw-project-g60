<?php
session_start();
include 'csrf_set.php';
set_csrf();
include_once('database/connection.php');
include_once('database/shelters.php');
include_once('database/users.php');
include_once('database/pets.php');

$shelter = getShelterByID($_GET['id']);
$adoption = getShelterPets($_GET['id']);
$pets = getShelterPetsAdopted($_GET['id']);

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/shelter_profile.php');
include('templates/common/footer.php');
