<?php

function console_log( $data ){
    echo '<script>';
    echo 'console.log('. json_encode( $data ) .')';
    echo '</script>';
}

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

    if ($users == false) {
        $shaPassword = sha1($password);
        $stmt = $db->prepare('SELECT * FROM Shelters WHERE username = :username AND password = :password');
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $shaPassword);

        if ($users == false) {
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function registerUser($name, $username, $password, $usertype, $profile_image, $header_image) {
    if ($usertype == "user") {
        global $db;
        $shaPassword = sha1($password);
        $stmt = $db->prepare('INSERT INTO Users(username, name, password, info) VALUES (:username, :name, :password, :info)');
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $shaPassword);
        $stmt->bindParam(':name', $name);
        $info = "Lorem Ipsum Things TODO here";
        $stmt->bindParam(':info', $info);

        $stmt->execute();

        $image_id = $db->lastInsertId();
        uploadImage($profile_image,$image_id,"images/users/profile");


    } else {
        global $db;
        $shaPassword = sha1($password);
        $stmt = $db->prepare('INSERT INTO Shelters(username, name, password, info) VALUES (:username, :name, :password, :info)');
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $shaPassword);
        $stmt->bindParam(':name', $name);
        $info = "Lorem Ipsum Things TODO here";
        $stmt->bindParam(':info', $info);

        $stmt->execute();

        $image_id = $db->lastInsertId();
        uploadImage($profile_image,$image_id,'images/shelters/profile');
        uploadImage($header_image,$image_id,'images/shelters/header');
    }
}

function getSessionId(){
    global $db;

    $stmt = $db->prepare('SELECT user_id FROM Users WHERE username = :username');
    $stmt->bindParam(':username', $_SESSION['username']);
    $stmt->execute();
    $user_id = $stmt->fetch()[0];

    if ($user_id == false) {
        $stmt = $db->prepare('SELECT shelter_id FROM Shelters WHERE username = :username');
        $stmt->bindParam(':username', $_SESSION['username']);
        $stmt->execute();
        return $stmt->fetch()[0];
    }else{
        return $user_id;
    }
}

function isUser($id){
    global $db;
    $stmt = $db->prepare('SELECT * FROM Users WHERE user_id = :id');
    $stmt->bindParam(':id', $id);

    $stmt->execute();
    $user = $stmt->fetch();

    if ($user == false) return false;
    return true;
}
