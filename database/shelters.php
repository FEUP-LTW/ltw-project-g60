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

function getShelterByUsername($username) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Shelters WHERE username = :username')) {
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        return $stmt->fetch();
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
        FROM Shelters, Shelters_Pets, Pets
        WHERE Shelters.shelter_id = :id
        AND Shelters_Pets.shelter_id = :id
        AND Shelters_Pets.pet_id = Pets.pet_id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getShelterPetsForAdoption($id) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT * 
        FROM Shelters, Pets_Adoption_Shelter, Pets
        WHERE Shelters.shelter_id = :id
        AND Pets_Adoption_Shelter.shelter_id = :id
        AND Pets_Adoption_Shelter.pet_id = Pets.pet_id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getShelterByID($shelterID) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Shelters WHERE shelter_id = :id')) {
        $stmt->bindParam(':id', $shelterID);
        $stmt->execute();
        return $stmt->fetch();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}