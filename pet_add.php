<?php
session_start();
include_once('database/connection.php');
include_once('database/pets.php');
include_once('database/shelters.php');
include_once('database/users.php');

$breeds = getBreeds();
$colors = getPetColors();

include('templates/common/header.php');

include('templates/common/navigation_bar.php');
include('templates/forms/pet_add.php');
include('templates/common/footer.php');