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

function getUserFavorites($id) {
  global $db;
  if ($stmt = $db->prepare('
        SELECT Pets.name as PetName, Pets.pet_id as PetID, Pets.info as PetInfo
        FROM Users, Favorites, Pets
        WHERE Users.user_id = :id
        AND Favorites.user_id = :id
        AND Favorites.pet_id = Pets.pet_id')) {
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

        $stmt->execute();
        $users = $stmt->fetch();
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
        uploadImage($header_image,$image_id,"images/users/header");
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
    $user_id = $stmt->fetch();

    if ($user_id == false) {
        $stmt = $db->prepare('SELECT shelter_id FROM Shelters WHERE username = :username');
        $stmt->bindParam(':username', $_SESSION['username']);
        $stmt->execute();
        return $stmt->fetch()[0];
    }else{
        return $user_id[0];
    }
}

function getUserActivity($id) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT *
        FROM Users, ProposalsUser 
        WHERE Users.user_id = ProposalsUser.user_id
        AND Users.user_id = :id
        ORDER BY date DESC 
        LIMIT 4')) {
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function isUser($username){
    global $db;
    $stmt = $db->prepare('SELECT * FROM Users WHERE username = :username');
    $stmt->bindParam(':username', $username);

    $stmt->execute();
    $user = $stmt->fetch();
    if ($user == false) return false;
    return true;
}

function getSheltersWithoutUserCollaboration($userID) {
    global $db;
    if ($stmt = $db->prepare('
        SELECT shelter_id, name
        FROM Shelters
        WHERE (
            shelter_id NOT IN (SELECT shelter_id
            FROM Collaborators 
            WHERE user_id == :id))')
        ) {
        $stmt->bindParam(':id', $userID);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function addProposal($text, $user_id, $pet_id){
    global $db;
    if ($stmt = $db->prepare('
        INSERT INTO 
        ProposalsUser(pet_id, user_id, date, text) 
        VALUES (:pet_id, :user_id, :date, :text)')) {

        $stmt->bindParam(':user_id', $user_id);
        $stmt->bindParam(':pet_id', $pet_id);
        $stmt->bindParam(':text', $text);
        $time = time();
        $stmt->bindParam(':date', $time);
        $stmt->execute();
    }
    else {
        printf('errno: %d, error: %s', $db->errorCode(), $db->errorInfo()[2]);
        die;
    }
}

function editUser($new_name, $new_username, $new_password, $usertype, $new_profile_image, $new_header_image, $collabs) {
    global $db;
    $session_id = getSessionId();

    if ($usertype == "user") {
        $shaPassword = sha1($new_password);
        $stmt = $db->prepare('UPDATE Users SET username = :username, password = :password, name = :name 
                                    WHERE user_id = :user_id');
        $stmt->bindParam(':username', $new_username);
        $stmt->bindParam(':password', $shaPassword);
        $stmt->bindParam(':name', $new_name);
        $stmt->bindParam(':user_id', $session_id);
        $stmt->execute();

        foreach ($collabs as $shelter_id) {
            $stmt = $db->prepare('INSERT INTO Collaborators(user_id,shelter_id) VALUES (:user_id,:shelter_id)');
            $stmt->bindParam(':user_id', $session_id);
            $int_shelter_id = (int)$shelter_id;
            $stmt->bindParam(':shelter_id', $int_shelter_id);

            $stmt->execute();
        }

        //image_id = session_id
        if ($new_profile_image['name'] != "") {
            uploadImage($new_profile_image, $session_id, "images/users/profile/");
        }
        if ($new_header_image['name'] != "") {
            uploadImage($new_header_image, $session_id, "images/users/header/");
        }
    }else{
        $shaPassword = sha1($new_password);
        $stmt = $db->prepare('UPDATE Shelters SET username = :username, password = :password, name = :name 
                                    WHERE shelter_id = :shelter_id');
        $stmt->bindParam(':username', $new_username);
        $stmt->bindParam(':password', $shaPassword);
        $stmt->bindParam(':name', $new_name);
        $stmt->bindParam(':shelter_id', $session_id);
        $stmt->execute();

        //image_id = session_id
        if ($new_profile_image['name'] != "") {
            uploadImage($new_profile_image, $session_id, "images/shelters/profile/");
        }
        if ($new_header_image['name'] != "") {
            uploadImage($new_header_image, $session_id, "images/shelters/header/");
        }
    }
}

function addFavoritePet($pet_id){
    global $db;
    $session_id = getSessionId();

    $stmt = $db->prepare('INSERT INTO Favorites(user_id, pet_id) VALUES (:user_id, :pet_id)');
    $stmt->bindParam(':pet_id', $pet_id);
    $stmt->bindParam(':user_id', $session_id);
    $stmt->execute();
    console_log("DID IT WORK?");
}
