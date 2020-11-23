<?php
session_start();
include_once('database/connection.php');
include_once('database/pets.php');

$pets = getAllPets();

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/pets_list.php');
include('templates/common/footer.php');