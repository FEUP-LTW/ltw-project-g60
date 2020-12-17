<?php
session_start();
include 'csrf_set.php';
set_csrf();

include_once('database/users.php');


include_once('templates/common/header.php');
include_once('templates/common/main_header.php');
include_once('templates/forms/login.php');
include_once('templates/common/footer.php');