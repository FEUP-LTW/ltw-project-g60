PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Shelters;
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Proposals;
DROP TABLE IF EXISTS Shelters_Pets;
DROP TABLE IF EXISTS Collaborators;
DROP TABLE IF EXISTS Favorites;

CREATE TABLE Users (
  user_id     INTEGER PRIMARY KEY,
  username    VARCHAR,
  password    TEXT,
  name        VARCHAR
);

CREATE TABLE Shelters (
  shelter_id  INTEGER PRIMARY KEY,
  username    VARCHAR,
  password    TEXT,
  name        VARCHAR
);

-- Pets or Posts with Pets
CREATE TABLE Pets (
  pet_id    INTEGER PRIMARY KEY,
  name      VARCHAR,
  species   VARCHAR,
  size      FLOAT,
  color     VARCHAR,
  location  VARCHAR,
  state     VARCHAR -- Pets can be in several states (being prepared for adoption, prepared, proposal accepted, delivered, …).
);

CREATE TABLE Proposals (
  prop_id   INTEGER PRIMARY KEY,
  pet_id    INTEGER,
  CONSTRAINT prop_fk1 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
);

CREATE TABLE Shelters_Pets (
  shelter_id  INTEGER,
  pet_id      INTEGER,
  CONSTRAINT shel_pet_fk1 FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id),
	CONSTRAINT shel_pet_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
	CONSTRAINT shel_pet_pk PRIMARY KEY(shelter_id)
);

CREATE TABLE Collaborators (
  shelter_id    INTEGER,
  user_id       INTEGER,
  CONSTRAINT collab_fk1 FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id),
  CONSTRAINT collab_fk2 FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT collab_pk PRIMARY KEY(shelter_id)
);

CREATE TABLE Favorites (
  user_id   INTEGER,
  pet_id    INTEGER,
  CONSTRAINT fav_fk1 FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT fav_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
	CONSTRAINT fav_pk PRIMARY KEY(user_id)
);


-- All passwords are 1234 in SHA-1 format
INSERT INTO Users (username, password, name) VALUES ("dominic", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "Dominic Woods");
INSERT INTO Users (username, password, name) VALUES ("zachary", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "Zachary Young");
INSERT INTO Users (username, password, name) VALUES ("alicia", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "Alicia Hamilton");
INSERT INTO Users (username, password, name) VALUES ("abril", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "Abril Cooley");


INSERT INTO Shelters (username, password, name) VALUES ("shelter_ze", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "Zé's Shelter");
INSERT INTO Shelters (username, password, name) VALUES ("gaia_shelter", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "V.N. de Gaia Shelter");

INSERT INTO Pets (name, species, size, color, location, state) VALUES (
  "Maria", 
  "labradoodle", 
  1.1,
  "blue",
  "V.N. de Gaia",
  "prepared"
);

INSERT INTO Proposals (pet_id) VALUES (1);
