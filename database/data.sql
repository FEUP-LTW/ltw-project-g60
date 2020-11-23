/*
Ficheiro para criar e popular base de dados
sqlite3 -init data.sql shelter.db  <- para criar .db file
*/
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Pets_Adoption_Shelter;
DROP TABLE IF EXISTS Favorites;
DROP TABLE IF EXISTS Collaborators;
DROP TABLE IF EXISTS Shelters_Pets;
DROP TABLE IF EXISTS Users_Pets;
DROP TABLE IF EXISTS Proposals;
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Shelters;
DROP TABLE IF EXISTS Users;

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
  gender    INTEGER, -- (0 for male),
  info      VARCHAR,
  age       INTEGER,
  location  VARCHAR,
  state     VARCHAR -- Pets can be in several states (being prepared for adoption, prepared, proposal accepted, delivered, …).
);

CREATE TABLE Proposals (
  prop_id   INTEGER PRIMARY KEY,
  pet_id    INTEGER,
  CONSTRAINT prop_fk1 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
);

-- Users owners of pets
CREATE TABLE Users_Pets (
  user_id   INTEGER,
  pet_id    INTEGER,
  CONSTRAINT own_fk1 FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT own_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
	CONSTRAINT own_pk PRIMARY KEY(user_id, pet_id)
);

-- Shelters owners of pets
CREATE TABLE Shelters_Pets (
  shelter_id  INTEGER,
  pet_id      INTEGER,
  CONSTRAINT shel_pet_fk1 FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id),
	CONSTRAINT shel_pet_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
	CONSTRAINT shel_pet_pk PRIMARY KEY(shelter_id, pet_id)
);

CREATE TABLE Collaborators (
  shelter_id    INTEGER,
  user_id       INTEGER,
  CONSTRAINT collab_fk1 FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id),
  CONSTRAINT collab_fk2 FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT collab_pk PRIMARY KEY(shelter_id, user_id)
);

CREATE TABLE Favorites (
  user_id   INTEGER,
  pet_id    INTEGER,
  CONSTRAINT fav_fk1 FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT fav_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
	CONSTRAINT fav_pk PRIMARY KEY(user_id, pet_id)
);

CREATE TABLE Pets_Adoption_Shelter(
    shelter_id  INTEGER,
    pet_id      INTEGER,
    CONSTRAINT shel_pet_fk1 FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id),
    CONSTRAINT shel_pet_fk2 FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    CONSTRAINT shel_pet_pk PRIMARY KEY(shelter_id, pet_id)
);

-- All passwords are 1234 in SHA-1 format
INSERT INTO Users (username, password, name) VALUES ('dominic', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Dominic Woods');
INSERT INTO Users (username, password, name) VALUES ('zachary', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Zachary Young');
INSERT INTO Users (username, password, name) VALUES ('alicia', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Alicia Hamilton');
INSERT INTO Users (username, password, name) VALUES ('abril', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Abril Cooley');


INSERT INTO Shelters (username, password, name) VALUES ('shelter_ze', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Zés Shelter');
INSERT INTO Shelters (username, password, name) VALUES ('gaia_shelter', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'V.N. de Gaia Shelter');

INSERT INTO Pets(name, species, size, color, gender, info, age, location, state) VALUES (
             'Maria',
            'labradoodle',
            1.1,
            'blue',
            1,
            'Lorem Ipsum Dolor Whatever',
            0,
            'V.N. de Gaia',
            'prepared');

INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Ponnappa', 
  'labrador', 
  2.2,
  'brown',
  0,
  'Lorem Ipsum Dolor Whatever',
  1,
  'New York',
  'prepared for adoption'
);
INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Stanbridge', 
  'german shepherd', 
  0.5,
  'green',
  0,
  'Lorem Ipsum Dolor Whatever',
  2,
  'Felgueiras',
  'delivered'
);
INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Tarryn', 
  'bulldog', 
  0.7,
  'yellow',
  1,
  'Lorem Ipsum Dolor Whatever',
  3,
  'Chaves',
  'proposal accepted'
);
INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Hayman', 
  'Beagle', 
  0.3,
  'cyan',
  0,
  'Lorem Ipsum Dolor Whatever',
  1,
  'Régua',
  'delivered'
);

insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Lesser mouse lemur', 'turpis', 1.8, 'Khaki', 1, 'amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit', 3, 'Cicurug', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Red and blue macaw', 'morbi non', 1.8, 'Turquoise', 1, 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere', 1, 'Daniwato', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Gull, kelp', 'justo in', 1.5, 'Blue', 0, 'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a', 1, 'Phoenix', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Racer snake', 'sit amet', 0.8, 'Blue', 1, 'nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu', 4, 'Shchastya', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Spotted deer', 'volutpat', 1.2, 'Mauv', 1, 'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', 4, 'Spånga', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Seal, harbor', 'lacinia aenean', 2.0, 'Maroon', 1, 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan', 2, 'Urukh', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Blue catfish', 'lectus', 1.3, 'Green', 0, 'sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque', 4, 'Siparia', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Moccasin, water', 'nullam', 0.7, 'Red', 0, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 2, 'Gore', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Vulture, king', 'donec', 0.2, 'Indigo', 1, 'amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh', 1, 'Luna', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Langur, hanuman', 'sem', 0.7, 'Turquoise', 0, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', 5, 'Stod', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Cat, cape wild', 'viverra diam', 1.3, 'Violet', 1, 'tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed', 1, 'Timurlorong', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Whale, killer', 'nullam', 0.9, 'Khaki', 0, 'ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper', 3, 'Liulin', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Eastern dwarf mongoose', 'mauris sit', 1.7, 'Yellow', 0, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque', 5, 'Ciénaga', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Black-backed jackal', 'non', 1.9, 'Goldenrod', 0, 'metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et', 5, 'Khon Kaen', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Squirrel, richardson''s ground', 'primis in', 1.9, 'Maroon', 1, 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris', 5, 'Ampelókipoi', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Black-capped capuchin', 'nec sem', 1.9, 'Orange', 1, 'in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 5, 'Kelasuri', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Collared peccary', 'et', 0.4, 'Pink', 0, 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum', 3, 'Tarnogskiy Gorodok', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Common wombat', 'nonummy', 1.8, 'Pink', 1, 'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus', 3, 'Feira de Santana', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Insect, stick', 'faucibus cursus', 0.8, 'Orange', 1, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus', 4, 'Rundeng', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Monkey, vervet', 'tellus in', 0.6, 'Goldenrod', 1, 'diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat', 1, 'Giemdiem', 'prepared');


INSERT INTO Proposals (pet_id) VALUES (1);
INSERT INTO Proposals (pet_id) VALUES (2);
INSERT INTO Proposals (pet_id) VALUES (4);
INSERT INTO Proposals (pet_id) VALUES (5);
INSERT INTO Proposals (pet_id) VALUES (3);

INSERT INTO Users_Pets (user_id, pet_id) VALUES (1,2);
INSERT INTO Users_Pets (user_id, pet_id) VALUES (3,1);
INSERT INTO Users_Pets (user_id, pet_id) VALUES (3,3);

INSERT INTO Shelters_Pets (shelter_id, pet_id) VALUES (1, 4);
INSERT INTO Shelters_Pets (shelter_id, pet_id) VALUES (2, 5);

INSERT INTO Collaborators (shelter_id, user_id) VALUES (1,1);
INSERT INTO Collaborators (shelter_id, user_id) VALUES (2,3);
INSERT INTO Collaborators (shelter_id, user_id) VALUES (2,4);

INSERT INTO Favorites (user_id, pet_id) VALUES (1,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (2,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (3,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (1,2);
INSERT INTO Favorites (user_id, pet_id) VALUES (2,3);
INSERT INTO Favorites (user_id, pet_id) VALUES (3,4);

INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 6);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 7);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 8);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 9);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 10);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 11);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 12);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 13);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (1, 14);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 15);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 16);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 17);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 18);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 19);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 20);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 21);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 22);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 23);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 24);
INSERT INTO Pets_Adoption_Shelter(shelter_id, pet_id) VALUES (2, 25);
