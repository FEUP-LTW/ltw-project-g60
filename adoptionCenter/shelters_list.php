<?php
session_start();
include 'csrf_set.php';
set_csrf();
include_once('../database/shelters.php');
include_once('../database/users.php');

$shelters = getAllShelters();

include('../templates/common/header.php');
include('../templates/common/navigation_bar.php');
include('../templates/pets/shelters_list.php');
include('../templates/common/footer.php');