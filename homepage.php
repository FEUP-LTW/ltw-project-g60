<?php
session_start();
set_csrf();

include_once('database/connection.php');
include_once('database/pets.php');
include_once('database/shelters.php');
include_once('database/users.php');

$pets = getFeaturedPets();
$shelter = getFeaturedShelter();

include('templates/common/header.php');
include('templates/common/main_header.php');
include('templates/pets/homepage.php');
include('templates/common/footer.php');