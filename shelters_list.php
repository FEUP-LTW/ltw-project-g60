<?php
session_start();
include_once('database/connection.php');
include_once('database/shelters.php');
include_once('database/users.php');

$shelters = getAllShelters();

include('templates/common/header.php');
include('templates/common/navigation_bar.php');
include('templates/pets/shelters_list.php');
include('templates/common/footer.php');