<?php
session_start();                         // starts the session
include_once('database/connection.php'); // connects to the database
include_once('database/pets.php');
include_once('database/users.php');

if (isset($_GET['pet_id']) && isset($_GET['prop_id'])) {
   acceptProposal($_GET['pet_id'], $_GET['prop_id']);
}

die();