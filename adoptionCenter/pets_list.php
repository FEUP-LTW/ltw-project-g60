<?php
session_start();
include 'csrf_set.php';
set_csrf();

include_once('../database/pets.php');
include_once('../database/shelters.php');
include_once('../database/users.php');

$pets = getAllPets();
$breeds = getBreeds();
$colors = getPetColors();

include('../templates/common/header.php');
include('../templates/common/navigation_bar.php');
include('../templates/pets/pets_list.php');
include('../templates/common/footer.php');