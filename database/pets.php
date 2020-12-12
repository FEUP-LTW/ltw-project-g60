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
    if ($stmt = $db->prepare('SELECT * FROM ProposalsUser WHERE pet_id = :id')) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return count($stmt->fetchAll());
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getPetProposals($petID) {
    global $db;
    if ($stmt = $db->prepare('
            SELECT * 
            FROM ProposalsUser, Users
            WHERE pet_id = :id
            AND Users.user_id = ProposalsUser.user_id')
    ) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return $stmt->fetchAll();
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

function addPet($id, $name, $image, $image_title, $species, $size, $color, $gender, $info, $age, $location) {
    global $db;

    $stmt = $db->prepare('INSERT INTO Pets(name, species, size, color, gender, info, age, location) 
            VALUES (:name, :species, :size, :color, :gender, :info, :age, :location)');
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':species', $species);
    $stmt->bindParam(':size', $size);
    $stmt->bindParam(':color', $color);
    $stmt->bindParam(':gender', $gender);
    $stmt->bindParam(':info', $info);
    $stmt->bindParam(':age', $age);
    $stmt->bindParam(':location', $location);

    $stmt->execute();

    $last_pet_id = $db->lastInsertId('pet_id');

    $stmt = $db->prepare("INSERT INTO Pets_Images VALUES(NULL, :pet_id, :title)");
    $stmt->bindParam(':pet_id', $last_pet_id);
    $stmt->bindParam(':title', $image_title);
    $stmt->execute();

    // Get image ID
    $image_id = $db->lastInsertId();

    uploadImage($image,$image_id);

    if (isUser($id)) {
        $stmt = $db->prepare('INSERT INTO Users_Pets(user_id, pet_id) VALUES (:user_id, :pet_id)');
        $stmt->bindParam(':user_id', $id);
        $stmt->bindParam(':pet_id', $last_pet_id);
        $stmt->execute();
    }else{
        $stmt = $db->prepare('INSERT INTO Shelters_Pets(user_id, pet_id) VALUES (:user_id, :pet_id)');
        $stmt->bindParam(':user_id', $id);
        $stmt->bindParam(':pet_id', $last_pet_id);
        $stmt->execute();
    }
}

function getImageByPetId($petID){
    global $db;
    if ($stmt = $db->prepare('SELECT * FROM Pets_Images WHERE pet_id = :id')) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return $stmt->fetch()[0];
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function getPetComments($petID) {
    global $db;
    if ($stmt = $db->prepare('
            SELECT * 
            FROM Comments, Users
            WHERE pet_id = :id
            AND Users.user_id = Comments.user_id
            ORDER BY date DESC')
    ) {
        $stmt->bindParam(':id', $petID);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function addPetComment($pet_id, $user_id, $text) {
    global $db;
    if ($stmt = $db->prepare('INSERT INTO Comments(user_id, pet_id, text, date) VALUES (:user_id, :pet_id, :text, :date)')) {
        $stmt->bindParam(':pet_id', $pet_id);
        $stmt->bindParam(':user_id', $user_id);
        $stmt->bindParam(':text', $text);
        $time = time();
        $stmt->bindParam(':date', $time);
        $stmt->execute();

        return $pet_id;
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}


