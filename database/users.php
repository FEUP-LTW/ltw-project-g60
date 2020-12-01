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

function getUserByUsername($username) {
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Users WHERE username = :username')) {
        $stmt->bindParam(':username', $username);
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

function userExists($username, $password)
{
    global $db;
    $shaPassword = sha1($password);
    $stmt = $db->prepare('SELECT * FROM Users WHERE username = :username AND password = :password');
    $stmt->bindParam(':username', $username);
    $stmt->bindParam(':password', $shaPassword);

    $stmt->execute();
    $users = $stmt->fetch();

    if (count($users) < 0) {
        $shaPassword = sha1($password);
        $stmt = $db->prepare('SELECT * FROM Shelters WHERE username = :username AND password = :password');
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $shaPassword);

        if (count($users) < 0) {
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function registerUser($name, $username, $password, $usertype) {

}