<?php

function console_log( $data ){
    echo '<script>';
    echo 'console.log('. json_encode( $data ) .')';
    echo '</script>';
}

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

function addPet($id, $name, $image, $species, $size, $color, $gender, $info, $age, $location) {
    global $db;

    $imagePath = saveImage($image);

    $stmt = $db->prepare('INSERT INTO Pets(name, species, imagePath, size, color, gender, info, age, location) 
            VALUES (:name, :species, :imagePath, :size, :color, :gender, :info, :age, :location)');
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':species', $species);
    $stmt->bindParam(':imagePath', $imagePath);
    $stmt->bindParam(':size', $size);
    $stmt->bindParam(':color', $color);
    $stmt->bindParam(':gender', $gender);
    $stmt->bindParam(':info', $info);
    $stmt->bindParam(':age', $age);
    $stmt->bindParam(':location', $location);

    $stmt->execute();

    if (isUser($id)) {
        $stmt = $db->prepare('INSERT INTO Users_Pets(user_id, pet_id) VALUES (:user_id, :pet_id)');
        $stmt->bindParam(':user_id', $id);
        $last_id = $db->lastInsertId('pet_id');
        $stmt->bindParam(':pet_id', $last_id);
        $stmt->execute();
    }else{
        $stmt = $db->prepare('INSERT INTO Shelters_Pets(user_id, pet_id) VALUES (:user_id, :pet_id)');
        $stmt->bindParam(':user_id', $id);
        $last_id = $db->lastInsertId('pet_id');
        $stmt->bindParam(':pet_id', $last_id);
        $stmt->execute();
    }
}

function saveImage($image){
    //Stores the filename as it was on the client computer.
    $imagename = $image['name'];
    //Stores the filetype e.g image/jpeg
    //$imagetype = $image['type'];
    //Stores the tempname as it is given by the host when uploaded.
    $imagetemp = $image['tmp_name'];

    //The path to upload the image to
    $imagePath = "./database/images/";

    if(is_uploaded_file($imagetemp)) {
        if(move_uploaded_file($imagetemp, $imagePath . $imagename)) {
            echo "Uploaded your image.";
            return $imagePath . $imagename;
        }
        else {
            echo "Failed to move your image.";
        }
    }
    else {
        echo "Failed to upload your image.";
    }
}
