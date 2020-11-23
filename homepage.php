<?php
session_start();
include_once('database/connection.php');
include_once('database/pets.php');
include_once('database/shelters.php');

$pets = getFeaturedPets();
$shelter = getFeaturedShelter();

include('templates/common/header.php');
include('templates/pets/homepage.php');
include('templates/common/footer.php');