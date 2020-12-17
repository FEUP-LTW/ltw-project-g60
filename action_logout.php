<?php
session_start();
set_csrf();
session_destroy();
header('Location: homepage.php');
die();