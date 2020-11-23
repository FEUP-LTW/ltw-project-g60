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

function getAllPets() {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Pets')) {
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getNumberOfProposals($petID) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Proposals WHERE pet_id = :id')) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return count($stmt->fetchAll());
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getPetOwner($petID) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT * 
        FROM Pets, Users_Pets
        WHERE Pets.pet_id = :id
        AND Pets.pet_id = Users_Pets.pet_id')) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        $pets = $stmt->fetch();
        if (!empty($pets)) return [$pets['user_id'], "user"];

        $stmt = $db->prepare('
            SELECT * 
            FROM Pets, Shelters_Pets 
            WHERE Pets.pet_id = :id
            AND Pets.pet_id = Shelters_Pets.pet_id');
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        $pets = $stmt->fetch();
        return [$pets['shelter_id'], "shelter"];
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getPetByID($petID) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Pets WHERE pet_id = :id')) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return $stmt->fetch();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}