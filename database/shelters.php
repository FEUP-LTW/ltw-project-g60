<?php

function getFeaturedShelter()
{
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Shelters')) {
        $stmt->execute();
        return $stmt->fetch();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}