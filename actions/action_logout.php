<?php
session_start();
session_destroy();
header('Location: ../adoptionCenter/homepage.php');
die();