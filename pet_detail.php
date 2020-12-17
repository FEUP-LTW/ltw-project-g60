<?php
session_start();
include 'csrf_set.php';
set_csrf();

include_once('database/connection.php');
include_once('database/pets.php');
include_once('database/users.php');
include_once('database/shelters.php');


$pet = getPetByID($_GET['id']);
$proposals = getPetProposals($_GET['id']);
$comments = getPetComments($_GET['id']);
$owner = getPetOwner($pet['pet_id']);

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/pet_detail.php');
include('templates/common/footer.php');
