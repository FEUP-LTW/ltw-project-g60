<?php

function getFeaturedPets()
{
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Pets')) {
        $stmt->execute();
        $pets = $stmt->fetchAll();
        return [$pets[0], $pets[1]];
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}