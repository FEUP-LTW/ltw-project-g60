<?php

function getUserByID($id) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Users WHERE user_id = :id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getUserPets($id) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT Pets.name as PetName, Pets.pet_id as PetID, Pets.info as PetInfo
        FROM Users, Users_Pets, Pets
        WHERE Users.user_id = :id
        AND Users_Pets.user_id = :id
        AND Users_Pets.pet_id = Pets.pet_id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getUserCollaborations($id) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT *
        FROM Shelters, Collaborators 
        WHERE Collaborators.user_id = :id
        AND Shelters.shelter_id = Collaborators.shelter_id')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}