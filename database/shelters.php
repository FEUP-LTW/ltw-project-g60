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

function getAllShelters() {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Shelters')) {
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getShelterPets($id) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT * 
        FROM Shelters, Shelters_Pets
        WHERE Shelters.shelter_id = :id
        AND Shelters_Pets.shelter_id = :id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}