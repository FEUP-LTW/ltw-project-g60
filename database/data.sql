/*
Ficheiro para criar e popular base de dados
sqlite3 -init data.sql shelter.db  <- para criar .db file
*/
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Answers;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Pets_Images;
DROP TABLE IF EXISTS Pets_Adopted_Shelter;
DROP TABLE IF EXISTS Favorites;
DROP TABLE IF EXISTS Collaborators;
DROP TABLE IF EXISTS Shelters_Pets;
DROP TABLE IF EXISTS Users_Pets;
DROP TABLE IF EXISTS ProposalsUser;
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Shelters;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Breeds;
DROP TABLE IF EXISTS Pets_Colors;

CREATE TABLE Users (
  user_id     INTEGER PRIMARY KEY,
  username    VARCHAR,
  password    TEXT,
  name        VARCHAR,
  info        VARCHAR
);

CREATE TABLE Shelters (
  shelter_id  INTEGER PRIMARY KEY,
  username    VARCHAR,
  password    TEXT,
  name        VARCHAR,
  info        VARCHAR
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

CREATE TABLE ProposalsUser (
    prop_id     INTEGER PRIMARY KEY,
    pet_id      INTEGER,
    user_id     INTEGER,
    text        VARCHAR,
    date        VARCHAR,
    state       VARCHAR,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Users owners of pets
CREATE TABLE Users_Pets (
  user_id   INTEGER,
  pet_id    INTEGER,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
	PRIMARY KEY(user_id, pet_id)
);

-- Shelters owners of pets
CREATE TABLE Shelters_Pets (
  shelter_id  INTEGER,
  pet_id      INTEGER,
  FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id) ON DELETE CASCADE,
	FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
	PRIMARY KEY(shelter_id, pet_id)
);

CREATE TABLE Collaborators (
  shelter_id    INTEGER,
  user_id       INTEGER,
  FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  PRIMARY KEY(shelter_id, user_id)
);

CREATE TABLE Favorites (
  user_id   INTEGER,
  pet_id    INTEGER,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
	FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
	PRIMARY KEY(user_id, pet_id)
);

CREATE TABLE Pets_Adopted_Shelter(
    shelter_id  INTEGER,
    pet_id      INTEGER,
    FOREIGN KEY (shelter_id) REFERENCES Shelters(shelter_id) ON DELETE CASCADE,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
    PRIMARY KEY(shelter_id, pet_id)
);

CREATE TABLE Pets_Images(
    img_id      INTEGER PRIMARY KEY,
    pet_id      INTEGER,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE
);

create table Comments (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    pet_id INTEGER,
    date VARCHAR,
    text VARCHAR,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Breeds (
    id INTEGER PRIMARY KEY,
    breed VARCHAR
);
CREATE TABLE Pets_Colors (
    id INTEGER PRIMARY KEY,
    color VARCHAR
);
create table Answers(
    id INTEGER PRIMARY KEY,
    comment_id INTEGER,
    date VARCHAR,
    text VARCHAR,
    user_id INTEGER,
    type VARCHAR, -- user or shelter
    FOREIGN KEY (comment_id) REFERENCES Comments ON DELETE CASCADE
);

-- All passwords are 1234 in SHA-1 format
INSERT INTO Users (username, password, name, info) VALUES ('dominic', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Dominic Woods', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');
INSERT INTO Users (username, password, name, info) VALUES ('zachary', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Zachary Young', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');
INSERT INTO Users (username, password, name, info) VALUES ('alicia', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Alicia Hamilton', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');
INSERT INTO Users (username, password, name, info) VALUES ('abril', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Abril Cooley', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');

INSERT INTO Shelters (username, password, name, info) VALUES ('shelter_ze', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Zés Shelter', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');
INSERT INTO Shelters (username, password, name, info) VALUES ('gaia_shelter', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'V.N. de Gaia Shelter', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dicta officia hic sit incidunt quia iusto que?');

INSERT INTO Pets(name, species, size, color, gender, info, age, location, state) VALUES (
     'Maria',
    'Selkirk Rex',
    1.1,
    'Amber',
    1,
    'Lorem Ipsum Dolor Whatever',
    0,
    'V.N. de Gaia',
    'prepared');

INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Ponnappa', 
  'Ocicat',
  2.2,
  'Black',
  0,
  'Lorem Ipsum Dolor Whatever',
  1,
  'New York',
  'prepared for adoption'
);
INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Stanbridge', 
  'Javanese',
  0.5,
  'Blue',
  0,
  'Lorem Ipsum Dolor Whatever',
  2,
  'Felgueiras',
  'delivered'
);
INSERT INTO Pets (name, species, size, color, gender, info, age, location, state) VALUES (
  'Tarryn', 
  'Corgi',
  0.7,
  'Yellow',
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
  'Brown',
  0,
  'Lorem Ipsum Dolor Whatever',
  1,
  'Régua',
  'delivered'
);

insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Lesser mouse lemur', 'Entlebucher', 1.8, 'Chocolate', 1, 'amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit', 3, 'Cicurug', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Red and blue macaw', 'Field Spaniel', 1.8, 'Cinnamon', 1, 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere', 1, 'Daniwato', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Gull, kelp', 'French Bulldog', 1.5, 'Cream', 0, 'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a', 1, 'Phoenix', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Racer snake', 'German Shepherd Dog', 0.8, 'Fown', 1, 'nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu', 4, 'Shchastya', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Spotted deer', 'Golden Retriever', 1.2, 'Isabella', 1, 'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', 4, 'Spånga', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Seal, harbor', 'Great Dane', 2.0, 'Lilac', 1, 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan', 2, 'Urukh', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Blue catfish', 'Hamiltonstovare', 1.3, 'Pale Amber', 0, 'sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque', 4, 'Siparia', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Moccasin, water', 'Hovawart', 0.7, 'Red', 0, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 2, 'Gore', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Vulture, king', 'Icelandic Sheepdog', 0.2, 'TortoiseShell', 1, 'amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh', 1, 'Luna', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Langur, hanuman', 'Irish Wolfhound', 0.7, 'Amber', 0, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', 5, 'Stod', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Cat, cape wild', 'Jindo', 1.3, 'Black', 1, 'tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed', 1, 'Timurlorong', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Whale, killer', 'Kai Dog', 0.9, 'Blue', 0, 'ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper', 3, 'Liulin', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Eastern dwarf mongoose', 'Kishu', 1.7, 'Yellow', 0, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque', 5, 'Ciénaga', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Black-backed jackal', 'Pit Bull Terrier', 1.9, 'Brown', 0, 'metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et', 5, 'Khon Kaen', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Squirrel, richardson''s ground', 'Kuvasz', 1.9, 'Chocolate', 1, 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris', 5, 'Ampelókipoi', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Black-capped capuchin', 'Labradoodle', 1.9, 'Cinnamon', 1, 'in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 5, 'Kelasuri', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Collared peccary', 'Leonberger', 0.4, 'Cream', 0, 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum', 3, 'Tarnogskiy Gorodok', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Common wombat', 'Maltese', 1.8, 'Fown', 1, 'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus', 3, 'Feira de Santana', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Insect, stick', 'McNab', 0.8, 'Isabella', 1, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus', 4, 'Rundeng', 'prepared');
insert into Pets (name, species, size, color, gender, info, age, location, state) values ('Monkey, vervet', 'Munsterlander', 0.6, 'Lilac', 1, 'diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat', 1, 'Giemdiem', 'prepared');

INSERT INTO Pets_Images (img_id,pet_id) VALUES (1,1);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (2,2);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (3,3);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (4,4);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (5,5);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (6,6);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (7,7);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (8,8);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (9,9);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (10,10);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (11,11);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (12,12);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (13,13);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (14,14);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (15,15);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (16,16);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (17,17);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (18,18);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (19,19);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (20,20);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (21,21);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (22,22);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (23,23);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (24,24);
INSERT INTO Pets_Images (img_id,pet_id) VALUES (25,25);

insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (1, 18, 4, 'at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu', '1600197253', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (2, 6, 2, 'cursus urna ut tellus nulla ut erat id mauris vulputate', '1605206240', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (3, 3, 1, 'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque', '1583693110', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (4, 5, 2, 'aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices', '1602890159', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (5, 7, 4, 'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras', '1583524441', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (6, 14, 3, 'malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin', '1577621675', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (7, 23, 4, 'turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor', '1586115831', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (8, 7, 1, 'justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia', '1581759149', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (9, 16, 2, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien', '1606539351', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (10, 14, 4, 'eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum', '1587304397', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (11, 5, 4, 'non pretium quis lectus suspendisse potenti in eleifend quam a', '1604515498', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (12, 3, 3, 'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae', '1582360474', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (13, 18, 3, 'odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem', '1598672422', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (14, 2, 1, 'luctus et ultrices posuere cubilia curae nulla dapibus dolor vel', '1603297921', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (15, 7, 1, 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed', '1600036958', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (16, 6, 4, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit', '1598669114', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (17, 25, 3, 'porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc', '1591573616', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (18, 25, 1, 'volutpat dui maecenas tristique est et tempus semper est quam pharetra', '1588131922', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (19, 20, 4, 'lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus', '1586120115', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (20, 2, 2, 'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', '1586892902', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (21, 14, 3, 'pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit', '1577593936', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (22, 23, 4, 'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero', '1593040680', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (23, 25, 4, 'dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in', '1605505273', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (24, 20, 1, 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis', '1597471727', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (25, 17, 3, 'molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate', '1592191865', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (26, 19, 1, 'massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida', '1588790704', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (27, 14, 4, 'pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum', '1589847398', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (28, 15, 3, 'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', '1602859913', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (29, 9, 3, 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient', '1594442597', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (30, 6, 2, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', '1600391164', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (31, 25, 1, 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet', '1597531755', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (32, 15, 3, 'ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum', '1603858008', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (33, 23, 4, 'mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu', '1595655493', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (34, 1, 4, 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', '1591091582', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (35, 15, 1, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis', '1595453298', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (36, 8, 2, 'dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat', '1592612832', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (37, 11, 1, 'porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id', '1606957436', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (38, 9, 3, 'eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis', '1598632878', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (39, 7, 1, 'non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus', '1606946802', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (40, 4, 4, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at', '1579598685', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (41, 15, 2, 'venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut', '1590801442', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (42, 18, 3, 'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras', '1587169961', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (43, 4, 1, 'aliquam erat volutpat in congue etiam justo etiam pretium iaculis', '1605585909', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (44, 4, 4, 'felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis', '1577810561', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (45, 25, 4, 'sodales sed tincidunt eu felis fusce posuere felis sed lacus', '1592824307', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (46, 22, 2, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed', '1605942171', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (47, 8, 2, 'id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum', '1594428593', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (48, 12, 4, 'lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam', '1595726480', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (49, 24, 1, 'libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla', '1606506619', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (50, 10, 3, 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus', '1600655978', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (51, 21, 3, 'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor', '1604161875', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (52, 18, 3, 'quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et', '1584772015', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (53, 11, 4, 'aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', '1583109542', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (54, 8, 2, 'donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum', '1606771096', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (55, 6, 2, 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla', '1607545076', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (56, 14, 3, 'donec ut mauris eget massa tempor convallis nulla neque libero', '1601156236', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (57, 5, 1, 'tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', '1587522867', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (58, 11, 4, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate', '1605975737', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (59, 4, 3, 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci', '1599833370', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (60, 7, 3, 'potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi', '1598447180', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (61, 6, 4, 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci', '1589332572', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (62, 19, 3, 'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce', '1594002817', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (63, 24, 4, 'nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat', '1593947124', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (64, 13, 2, 'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non', '1607114212', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (65, 2, 2, 'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus', '1598494282', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (66, 5, 2, 'consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel', '1587046233', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (67, 3, 1, 'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed', '1591195546', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (68, 19, 3, 'pede justo eu massa donec dapibus duis at velit eu est', '1592533451', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (69, 9, 1, 'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque', '1598755262', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (70, 8, 1, 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium', '1601505013', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (71, 24, 1, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices', '1601946681', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (72, 24, 3, 'justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus', '1595612274', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (73, 8, 3, 'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium', '1591243073', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (74, 15, 3, 'urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst', '1594542023', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (75, 22, 1, 'augue a suscipit nulla elit ac nulla sed vel enim', '1586320917', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (76, 2, 4, 'purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', '1579879753', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (77, 23, 4, 'nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus', '1602137993', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (78, 22, 2, 'iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci', '1596912536', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (79, 2, 3, 'cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel', '1587668651', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (80, 6, 1, 'aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate', '1599753791', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (81, 13, 3, 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum', '1576424518', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (82, 25, 3, 'erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea', '1594461404', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (83, 24, 4, 'ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis', '1595373703', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (84, 18, 4, 'aenean auctor gravida sem praesent id massa id nisl venenatis', '1583455886', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (85, 10, 3, 'integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo', '1606099338', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (86, 12, 4, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis', '1592569580', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (87, 2, 2, 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros', '1602829892', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (88, 23, 2, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor', '1588274694', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (89, 2, 1, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus', '1596592059', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (90, 11, 1, 'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum', '1589567598', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (91, 4, 1, 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede', '1603839961', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (92, 12, 4, 'orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus', '1594748238', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (93, 8, 1, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede', '1598098625', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (94, 9, 4, 'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero', '1598465705', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (95, 14, 3, 'mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat', '1583853505', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (96, 16, 4, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci', '1599926776', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (97, 6, 1, 'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices', '1578394727', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (98, 12, 2, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', '1582709630', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (99, 5, 3, 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', '1589025767', 'waiting');
insert into ProposalsUser (prop_id, pet_id, user_id, text, date, state) values (100, 18, 3, 'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam', '1602071747', 'waiting');

INSERT INTO Users_Pets (user_id, pet_id) VALUES (1,2);
INSERT INTO Users_Pets (user_id, pet_id) VALUES (3,1);
INSERT INTO Users_Pets (user_id, pet_id) VALUES (3,3);
insert into Users_Pets (user_id, pet_id) values (2, 6);
insert into Users_Pets (user_id, pet_id) values (2, 7);
insert into Users_Pets (user_id, pet_id) values (2, 8);
insert into Users_Pets (user_id, pet_id) values (3, 9);
insert into Users_Pets (user_id, pet_id) values (4, 10);
insert into Users_Pets (user_id, pet_id) values (3, 11);
insert into Users_Pets (user_id, pet_id) values (2, 12);
insert into Users_Pets (user_id, pet_id) values (4, 13);
insert into Users_Pets (user_id, pet_id) values (4, 14);
insert into Users_Pets (user_id, pet_id) values (3, 15);
insert into Users_Pets (user_id, pet_id) values (2, 16);
insert into Users_Pets (user_id, pet_id) values (2, 17);
insert into Users_Pets (user_id, pet_id) values (4, 18);


INSERT INTO Shelters_Pets (shelter_id, pet_id) VALUES (1, 4);
INSERT INTO Shelters_Pets (shelter_id, pet_id) VALUES (2, 5);
insert into Shelters_Pets(shelter_id, pet_id) values (1, 19);
insert into Shelters_Pets(shelter_id, pet_id) values (2, 20);
insert into Shelters_Pets(shelter_id, pet_id) values (1, 21);
insert into Shelters_Pets(shelter_id, pet_id) values (1, 22);
insert into Shelters_Pets(shelter_id, pet_id) values (1, 23);
insert into Shelters_Pets(shelter_id, pet_id) values (2, 24);
insert into Shelters_Pets(shelter_id, pet_id) values (1, 25);


INSERT INTO Collaborators (shelter_id, user_id) VALUES (1,1);
INSERT INTO Collaborators (shelter_id, user_id) VALUES (2,3);
INSERT INTO Collaborators (shelter_id, user_id) VALUES (2,4);

INSERT INTO Favorites (user_id, pet_id) VALUES (1,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (2,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (3,1);
INSERT INTO Favorites (user_id, pet_id) VALUES (1,2);
INSERT INTO Favorites (user_id, pet_id) VALUES (2,3);
INSERT INTO Favorites (user_id, pet_id) VALUES (3,4);

INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 6);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 7);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 8);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 9);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 10);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 11);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 12);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 13);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (1, 14);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 15);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 16);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 17);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 18);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 19);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 20);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 21);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 22);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 23);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 24);
INSERT INTO Pets_Adopted_Shelter(shelter_id, pet_id) VALUES (2, 25);

insert into Comments (id, user_id, pet_id, date, text) values (1, 3, 25, '1602493775', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Comments (id, user_id, pet_id, date, text) values (2, 2, 5, '1579097540', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
insert into Comments (id, user_id, pet_id, date, text) values (3, 4, 9, '1590164055', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
insert into Comments (id, user_id, pet_id, date, text) values (4, 2, 18, '1599121253', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.');
insert into Comments (id, user_id, pet_id, date, text) values (5, 4, 3, '1589509864', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
insert into Comments (id, user_id, pet_id, date, text) values (6, 2, 13, '1592518368', 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.');
insert into Comments (id, user_id, pet_id, date, text) values (7, 1, 8, '1595160240', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.');
insert into Comments (id, user_id, pet_id, date, text) values (8, 1, 21, '1576395696', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.');
insert into Comments (id, user_id, pet_id, date, text) values (9, 2, 21, '1587354328', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into Comments (id, user_id, pet_id, date, text) values (10, 1, 7, '1604514721', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
insert into Comments (id, user_id, pet_id, date, text) values (11, 1, 22, '1595053802', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.');
insert into Comments (id, user_id, pet_id, date, text) values (12, 3, 11, '1576640085', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.');
insert into Comments (id, user_id, pet_id, date, text) values (13, 1, 25, '1585700296', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.');
insert into Comments (id, user_id, pet_id, date, text) values (14, 4, 2, '1597516580', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
insert into Comments (id, user_id, pet_id, date, text) values (15, 3, 23, '1596146599', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.');
insert into Comments (id, user_id, pet_id, date, text) values (16, 3, 19, '1592779731', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
insert into Comments (id, user_id, pet_id, date, text) values (17, 4, 14, '1586809654', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into Comments (id, user_id, pet_id, date, text) values (18, 2, 9, '1586808383', 'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.');
insert into Comments (id, user_id, pet_id, date, text) values (19, 1, 4, '1588769876', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into Comments (id, user_id, pet_id, date, text) values (20, 1, 7, '1595803935', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.');
insert into Comments (id, user_id, pet_id, date, text) values (21, 1, 21, '1593530512', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into Comments (id, user_id, pet_id, date, text) values (22, 4, 23, '1578197442', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
insert into Comments (id, user_id, pet_id, date, text) values (23, 4, 4, '1582261610', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
insert into Comments (id, user_id, pet_id, date, text) values (24, 2, 9, '1604100302', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
insert into Comments (id, user_id, pet_id, date, text) values (25, 1, 16, '1597986373', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
insert into Comments (id, user_id, pet_id, date, text) values (26, 1, 20, '1590693390', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.');
insert into Comments (id, user_id, pet_id, date, text) values (27, 3, 6, '1599895973', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
insert into Comments (id, user_id, pet_id, date, text) values (28, 4, 20, '1603190271', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.');
insert into Comments (id, user_id, pet_id, date, text) values (29, 3, 4, '1592455796', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
insert into Comments (id, user_id, pet_id, date, text) values (30, 2, 24, '1599772810', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
insert into Comments (id, user_id, pet_id, date, text) values (31, 3, 7, '1579266507', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.');
insert into Comments (id, user_id, pet_id, date, text) values (32, 3, 18, '1590433103', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Comments (id, user_id, pet_id, date, text) values (33, 3, 7, '1591157600', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
insert into Comments (id, user_id, pet_id, date, text) values (34, 2, 24, '1599053267', 'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.');
insert into Comments (id, user_id, pet_id, date, text) values (35, 4, 23, '1593784693', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.');
insert into Comments (id, user_id, pet_id, date, text) values (36, 4, 8, '1601815730', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.');
insert into Comments (id, user_id, pet_id, date, text) values (37, 1, 1, '1587792223', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Comments (id, user_id, pet_id, date, text) values (38, 2, 15, '1604469733', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
insert into Comments (id, user_id, pet_id, date, text) values (39, 2, 3, '1603323289', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
insert into Comments (id, user_id, pet_id, date, text) values (40, 4, 15, '1604812460', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
insert into Comments (id, user_id, pet_id, date, text) values (41, 3, 25, '1605999747', 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into Comments (id, user_id, pet_id, date, text) values (42, 2, 1, '1576077905', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.');
insert into Comments (id, user_id, pet_id, date, text) values (43, 2, 14, '1591264628', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Comments (id, user_id, pet_id, date, text) values (44, 3, 12, '1581017249', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
insert into Comments (id, user_id, pet_id, date, text) values (45, 2, 5, '1596623814', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Comments (id, user_id, pet_id, date, text) values (46, 3, 13, '1576596464', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
insert into Comments (id, user_id, pet_id, date, text) values (47, 1, 9, '1590063370', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
insert into Comments (id, user_id, pet_id, date, text) values (48, 2, 24, '1583119276', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.');
insert into Comments (id, user_id, pet_id, date, text) values (49, 1, 1, '1584806144', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into Comments (id, user_id, pet_id, date, text) values (50, 4, 4, '1581462374', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');

insert into Answers (id, comment_id, date, text, user_id, type) values (1, 26, '1586171365', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (2, 35, '1599007019', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (3, 22, '1604925650', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (4, 49, '1593208818', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (5, 49, '1579586019', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 2, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (6, 37, '1593437292', 'In congue. Etiam justo. Etiam pretium iaculis justo.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (7, 12, '1578651337', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (27, 23, '1577910676', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (28, 50, '1601903586', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (29, 1, '1603153993', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (30, 4, '1606806721', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (31, 5, '1597399658', 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (32, 9, '1606826312', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (33, 11, '1586555075', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (34, 14, '1584598868', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (35, 17, '1602253882', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (36, 19, '1605229050', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (37, 22, '1584995213', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (38, 23, '1590548710', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (39, 28, '1588247027', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 2, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (40, 27, '1583894509', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (41, 10, '1587056270', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 2, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (42, 9, '1600032625', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 4, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (43, 2, '1606859501', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 2, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (44, 4, '1581226785', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (45, 44, '1588083347', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (46, 43, '1599083946', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 1, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (47, 47, '1594222905', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 3, 'user');
insert into Answers (id, comment_id, date, text, user_id, type) values (48, 48, '1581650499', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 1, 'user');


insert into Breeds (id, breed) values (1, 'Abyssinian');
insert into Breeds (id, breed) values (2, 'American Bobtail');
insert into Breeds (id, breed) values (3, 'American Curl');
insert into Breeds (id, breed) values (4, 'American Shorthair');
insert into Breeds (id, breed) values (5, 'American Wirehair');
insert into Breeds (id, breed) values (6, 'Applehead Siamese');
insert into Breeds (id, breed) values (7, 'Balinese');
insert into Breeds (id, breed) values (8, 'Bengal');
insert into Breeds (id, breed) values (9, 'Birman');
insert into Breeds (id, breed) values (10, 'Bombay');
insert into Breeds (id, breed) values (11, 'British Shorthair');
insert into Breeds (id, breed) values (12, 'Burmese');
insert into Breeds (id, breed) values (13, 'Burmilla');
insert into Breeds (id, breed) values (14, 'Calico');
insert into Breeds (id, breed) values (15, 'Canadian Hairless');
insert into Breeds (id, breed) values (16, 'Chartreux');
insert into Breeds (id, breed) values (17, 'Chausie');
insert into Breeds (id, breed) values (18, 'Chinchilla');
insert into Breeds (id, breed) values (19, 'Cornish Rex');
insert into Breeds (id, breed) values (20, 'Cymric');
insert into Breeds (id, breed) values (21, 'Devon Rex');
insert into Breeds (id, breed) values (22, 'Dilute Calico');
insert into Breeds (id, breed) values (23, 'Dilute Tortoiseshell');
insert into Breeds (id, breed) values (24, 'Domestic Long Hair');
insert into Breeds (id, breed) values (25, 'Domestic Medium Hair');
insert into Breeds (id, breed) values (26, 'Domestic Short Hair');
insert into Breeds (id, breed) values (27, 'Egyptian Mau');
insert into Breeds (id, breed) values (28, 'Exotic Shorthair');
insert into Breeds (id, breed) values (29, 'Extra-Toes Cat');
insert into Breeds (id, breed) values (30, 'Havana');
insert into Breeds (id, breed) values (31, 'Himalayan');
insert into Breeds (id, breed) values (32, 'Japanese Bobtail');
insert into Breeds (id, breed) values (33, 'Javanese');
insert into Breeds (id, breed) values (34, 'Korat');
insert into Breeds (id, breed) values (35, 'LaPerm');
insert into Breeds (id, breed) values (36, 'Maine Coon');
insert into Breeds (id, breed) values (37, 'Manx');
insert into Breeds (id, breed) values (38, 'Munchkin');
insert into Breeds (id, breed) values (39, 'Nebelung');
insert into Breeds (id, breed) values (40, 'Norwegian Forest Cat');
insert into Breeds (id, breed) values (41, 'Ocicat');
insert into Breeds (id, breed) values (42, 'Oriental Long Hair');
insert into Breeds (id, breed) values (43, 'Oriental Short Hair');
insert into Breeds (id, breed) values (44, 'Oriental Tabby');
insert into Breeds (id, breed) values (45, 'Persian');
insert into Breeds (id, breed) values (46, 'Pixiebob');
insert into Breeds (id, breed) values (47, 'Ragamuffin');
insert into Breeds (id, breed) values (48, 'Ragdoll');
insert into Breeds (id, breed) values (49, 'Russian Blue');
insert into Breeds (id, breed) values (50, 'Scottish Fold');
insert into Breeds (id, breed) values (51, 'Selkirk Rex');
insert into Breeds (id, breed) values (52, 'Siamese');
insert into Breeds (id, breed) values (53, 'Siberian');
insert into Breeds (id, breed) values (54, 'Silver');
insert into Breeds (id, breed) values (55, 'Singapura');
insert into Breeds (id, breed) values (56, 'Snowshoe');
insert into Breeds (id, breed) values (57, 'Somali');
insert into Breeds (id, breed) values (58, 'Sphynx');
insert into Breeds (id, breed) values (59, 'Tabby');
insert into Breeds (id, breed) values (60, 'Tiger');
insert into Breeds (id, breed) values (61, 'Tonkinese');
insert into Breeds (id, breed) values (62, 'Torbie');
insert into Breeds (id, breed) values (63, 'Tortoiseshell');
insert into Breeds (id, breed) values (64, 'Toyger');
insert into Breeds (id, breed) values (65, 'Turkish Angora');
insert into Breeds (id, breed) values (66, 'Turkish Van');
insert into Breeds (id, breed) values (67, 'Tuxedo');
insert into Breeds (id, breed) values (68, 'York Chocolate');
insert into Breeds (id, breed) values (69, 'Affenpinscher');
insert into Breeds (id, breed) values (70, 'Afghan Hound');
insert into Breeds (id, breed) values (71, 'Airedale Terrier');
insert into Breeds (id, breed) values (72, 'Akbash');
insert into Breeds (id, breed) values (73, 'Akita');
insert into Breeds (id, breed) values (74, 'Alaskan Malamute');
insert into Breeds (id, breed) values (75, 'American Bulldog');
insert into Breeds (id, breed) values (76, 'American Bully');
insert into Breeds (id, breed) values (77, 'American Eskimo Dog');
insert into Breeds (id, breed) values (78, 'American Foxhound');
insert into Breeds (id, breed) values (79, 'American Hairless Terrier');
insert into Breeds (id, breed) values (80, 'American Staffordshire Terrier');
insert into Breeds (id, breed) values (81, 'American Water Spaniel');
insert into Breeds (id, breed) values (82, 'Anatolian Shepherd');
insert into Breeds (id, breed) values (83, 'Appenzell Mountain Dog');
insert into Breeds (id, breed) values (84, 'Aussiedoodle');
insert into Breeds (id, breed) values (85, 'Australian Cattle Dog');
insert into Breeds (id, breed) values (86, 'Australian Kelpie');
insert into Breeds (id, breed) values (87, 'Australian Shepherd');
insert into Breeds (id, breed) values (88, 'Australian Terrier');
insert into Breeds (id, breed) values (89, 'Basenji');
insert into Breeds (id, breed) values (90, 'Basset Hound');
insert into Breeds (id, breed) values (91, 'Beagle');
insert into Breeds (id, breed) values (92, 'Bearded Collie');
insert into Breeds (id, breed) values (93, 'Beauceron');
insert into Breeds (id, breed) values (94, 'Bedlington Terrier');
insert into Breeds (id, breed) values (95, 'Belgian Shepherd');
insert into Breeds (id, breed) values (96, 'Belgian Shepherd');
insert into Breeds (id, breed) values (97, 'Belgian Shepherd');
insert into Breeds (id, breed) values (98, 'Belgian Shepherd');
insert into Breeds (id, breed) values (99, 'Bernedoodle');
insert into Breeds (id, breed) values (100, 'Bernese Mountain Dog');
insert into Breeds (id, breed) values (101, 'Bichon Frise');
insert into Breeds (id, breed) values (102, 'Black and Tan Coonhound');
insert into Breeds (id, breed) values (103, 'Black Labrador Retriever');
insert into Breeds (id, breed) values (104, 'Black Mouth Cur');
insert into Breeds (id, breed) values (105, 'Black Russian Terrier');
insert into Breeds (id, breed) values (106, 'Bloodhound');
insert into Breeds (id, breed) values (107, 'Blue Lacy');
insert into Breeds (id, breed) values (108, 'Bluetick Coonhound');
insert into Breeds (id, breed) values (109, 'Boerboel');
insert into Breeds (id, breed) values (110, 'Bolognese');
insert into Breeds (id, breed) values (111, 'Border Collie');
insert into Breeds (id, breed) values (112, 'Border Terrier');
insert into Breeds (id, breed) values (113, 'Borzoi');
insert into Breeds (id, breed) values (114, 'Boston Terrier');
insert into Breeds (id, breed) values (115, 'Bouvier des Flandres');
insert into Breeds (id, breed) values (116, 'Boxer');
insert into Breeds (id, breed) values (117, 'Boykin Spaniel');
insert into Breeds (id, breed) values (118, 'Briard');
insert into Breeds (id, breed) values (119, 'Brittany Spaniel');
insert into Breeds (id, breed) values (120, 'Brussels Griffon');
insert into Breeds (id, breed) values (121, 'Bull Terrier');
insert into Breeds (id, breed) values (122, 'Bullmastiff');
insert into Breeds (id, breed) values (123, 'Cairn Terrier');
insert into Breeds (id, breed) values (124, 'Canaan Dog');
insert into Breeds (id, breed) values (125, 'Cane Corso');
insert into Breeds (id, breed) values (126, 'Cardigan Welsh Corgi');
insert into Breeds (id, breed) values (127, 'Carolina Dog');
insert into Breeds (id, breed) values (128, 'Catahoula Leopard Dog');
insert into Breeds (id, breed) values (129, 'Cattle Dog');
insert into Breeds (id, breed) values (130, 'Caucasian Sheepdog');
insert into Breeds (id, breed) values (131, 'Cavachon');
insert into Breeds (id, breed) values (132, 'Cavalier King Charles Spaniel');
insert into Breeds (id, breed) values (133, 'Cavapoo');
insert into Breeds (id, breed) values (134, 'Chesapeake Bay Retriever');
insert into Breeds (id, breed) values (135, 'Chihuahua');
insert into Breeds (id, breed) values (136, 'Chinese Crested Dog');
insert into Breeds (id, breed) values (137, 'Chinese Foo Dog');
insert into Breeds (id, breed) values (138, 'Chinook');
insert into Breeds (id, breed) values (139, 'Chiweenie');
insert into Breeds (id, breed) values (140, 'Chocolate Labrador Retriever');
insert into Breeds (id, breed) values (141, 'Chow Chow');
insert into Breeds (id, breed) values (142, 'Cirneco dellEtna');
insert into Breeds (id, breed) values (143, 'Clumber Spaniel');
insert into Breeds (id, breed) values (144, 'Cockapoo');
insert into Breeds (id, breed) values (145, 'Cocker Spaniel');
insert into Breeds (id, breed) values (146, 'Collie');
insert into Breeds (id, breed) values (147, 'Coonhound');
insert into Breeds (id, breed) values (148, 'Corgi');
insert into Breeds (id, breed) values (149, 'Coton de Tulear');
insert into Breeds (id, breed) values (150, 'Curly-Coated Retriever');
insert into Breeds (id, breed) values (151, 'Dachshund');
insert into Breeds (id, breed) values (152, 'Dalmatian');
insert into Breeds (id, breed) values (153, 'Dandie Dinmont Terrier');
insert into Breeds (id, breed) values (154, 'Doberman Pinscher');
insert into Breeds (id, breed) values (155, 'Dogo Argentino');
insert into Breeds (id, breed) values (156, 'Dogue de Bordeaux');
insert into Breeds (id, breed) values (157, 'Dutch Shepherd');
insert into Breeds (id, breed) values (158, 'English Bulldog');
insert into Breeds (id, breed) values (159, 'English Cocker Spaniel');
insert into Breeds (id, breed) values (160, 'English Coonhound');
insert into Breeds (id, breed) values (161, 'English Foxhound');
insert into Breeds (id, breed) values (162, 'English Pointer');
insert into Breeds (id, breed) values (163, 'English Setter');
insert into Breeds (id, breed) values (164, 'English Shepherd');
insert into Breeds (id, breed) values (165, 'English Springer Spaniel');
insert into Breeds (id, breed) values (166, 'English Toy Spaniel');
insert into Breeds (id, breed) values (167, 'Entlebucher');
insert into Breeds (id, breed) values (168, 'Eskimo Dog');
insert into Breeds (id, breed) values (169, 'Feist');
insert into Breeds (id, breed) values (170, 'Field Spaniel');
insert into Breeds (id, breed) values (171, 'Fila Brasileiro');
insert into Breeds (id, breed) values (172, 'Finnish Lapphund');
insert into Breeds (id, breed) values (173, 'Finnish Spitz');
insert into Breeds (id, breed) values (174, 'Flat-Coated Retriever');
insert into Breeds (id, breed) values (175, 'Fox Terrier');
insert into Breeds (id, breed) values (176, 'Foxhound');
insert into Breeds (id, breed) values (177, 'French Bulldog');
insert into Breeds (id, breed) values (178, 'Galgo Spanish Greyhound');
insert into Breeds (id, breed) values (179, 'German Pinscher');
insert into Breeds (id, breed) values (180, 'German Shepherd Dog');
insert into Breeds (id, breed) values (181, 'German Shorthaired Pointer');
insert into Breeds (id, breed) values (182, 'German Spitz');
insert into Breeds (id, breed) values (183, 'German Wirehaired Pointer');
insert into Breeds (id, breed) values (184, 'Giant Schnauzer');
insert into Breeds (id, breed) values (185, 'Glen of Imaal Terrier');
insert into Breeds (id, breed) values (186, 'Golden Retriever');
insert into Breeds (id, breed) values (187, 'Goldendoodle');
insert into Breeds (id, breed) values (188, 'Gordon Setter');
insert into Breeds (id, breed) values (189, 'Great Dane');
insert into Breeds (id, breed) values (190, 'Great Pyrenees');
insert into Breeds (id, breed) values (191, 'Greater Swiss Mountain Dog');
insert into Breeds (id, breed) values (192, 'Greyhound');
insert into Breeds (id, breed) values (193, 'Hamiltonstovare');
insert into Breeds (id, breed) values (194, 'Harrier');
insert into Breeds (id, breed) values (195, 'Havanese');
insert into Breeds (id, breed) values (196, 'Hound');
insert into Breeds (id, breed) values (197, 'Hovawart');
insert into Breeds (id, breed) values (198, 'Husky');
insert into Breeds (id, breed) values (199, 'Ibizan Hound');
insert into Breeds (id, breed) values (200, 'Icelandic Sheepdog');
insert into Breeds (id, breed) values (201, 'Illyrian Sheepdog');
insert into Breeds (id, breed) values (202, 'Irish Setter');
insert into Breeds (id, breed) values (203, 'Irish Terrier');
insert into Breeds (id, breed) values (204, 'Irish Water Spaniel');
insert into Breeds (id, breed) values (205, 'Irish Wolfhound');
insert into Breeds (id, breed) values (206, 'Italian Greyhound');
insert into Breeds (id, breed) values (207, 'Jack Russell Terrier');
insert into Breeds (id, breed) values (208, 'Japanese Chin');
insert into Breeds (id, breed) values (209, 'Jindo');
insert into Breeds (id, breed) values (210, 'Kai Dog');
insert into Breeds (id, breed) values (211, 'Karelian Bear Dog');
insert into Breeds (id, breed) values (212, 'Keeshond');
insert into Breeds (id, breed) values (213, 'Kerry Blue Terrier');
insert into Breeds (id, breed) values (214, 'Kishu');
insert into Breeds (id, breed) values (215, 'Klee Kai');
insert into Breeds (id, breed) values (216, 'Komondor');
insert into Breeds (id, breed) values (217, 'Kuvasz');
insert into Breeds (id, breed) values (218, 'Kyi Leo');
insert into Breeds (id, breed) values (219, 'Labradoodle');
insert into Breeds (id, breed) values (220, 'Labrador Retriever');
insert into Breeds (id, breed) values (221, 'Lakeland Terrier');
insert into Breeds (id, breed) values (222, 'Lancashire Heeler');
insert into Breeds (id, breed) values (223, 'Leonberger');
insert into Breeds (id, breed) values (224, 'Lhasa Apso');
insert into Breeds (id, breed) values (225, 'Lowchen');
insert into Breeds (id, breed) values (226, 'Lurcher');
insert into Breeds (id, breed) values (227, 'Maltese');
insert into Breeds (id, breed) values (228, 'Maltipoo');
insert into Breeds (id, breed) values (229, 'Manchester Terrier');
insert into Breeds (id, breed) values (230, 'Maremma Sheepdog');
insert into Breeds (id, breed) values (231, 'Mastiff');
insert into Breeds (id, breed) values (232, 'McNab');
insert into Breeds (id, breed) values (233, 'Miniature Bull Terrier');
insert into Breeds (id, breed) values (234, 'Miniature Dachshund');
insert into Breeds (id, breed) values (235, 'Miniature Pinscher');
insert into Breeds (id, breed) values (236, 'Miniature Poodle');
insert into Breeds (id, breed) values (237, 'Miniature Schnauzer');
insert into Breeds (id, breed) values (238, 'Mixed Breed');
insert into Breeds (id, breed) values (239, 'Morkie');
insert into Breeds (id, breed) values (240, 'Mountain Cur');
insert into Breeds (id, breed) values (241, 'Mountain Dog');
insert into Breeds (id, breed) values (242, 'Munsterlander');
insert into Breeds (id, breed) values (243, 'Neapolitan Mastiff');
insert into Breeds (id, breed) values (244, 'New Guinea Singing Dog');
insert into Breeds (id, breed) values (245, 'Newfoundland Dog');
insert into Breeds (id, breed) values (246, 'Norfolk Terrier');
insert into Breeds (id, breed) values (247, 'Norwegian Buhund');
insert into Breeds (id, breed) values (248, 'Norwegian Elkhound');
insert into Breeds (id, breed) values (249, 'Norwegian Lundehund');
insert into Breeds (id, breed) values (250, 'Norwich Terrier');
insert into Breeds (id, breed) values (251, 'Nova Scotia Duck Tolling Retriever');
insert into Breeds (id, breed) values (252, 'Old English Sheepdog');
insert into Breeds (id, breed) values (253, 'Otterhound');
insert into Breeds (id, breed) values (254, 'Papillon');
insert into Breeds (id, breed) values (255, 'Parson Russell Terrier');
insert into Breeds (id, breed) values (256, 'Patterdale Terrier');
insert into Breeds (id, breed) values (257, 'Pekingese');
insert into Breeds (id, breed) values (258, 'Pembroke Welsh Corgi');
insert into Breeds (id, breed) values (259, 'Peruvian Inca Orchid');
insert into Breeds (id, breed) values (260, 'Petit Basset Griffon Vendeen');
insert into Breeds (id, breed) values (261, 'Pharaoh Hound');
insert into Breeds (id, breed) values (262, 'Pit Bull Terrier');
insert into Breeds (id, breed) values (263, 'Plott Hound');
insert into Breeds (id, breed) values (264, 'Pointer');
insert into Breeds (id, breed) values (265, 'Polish Lowland Sheepdog');
insert into Breeds (id, breed) values (266, 'Pomeranian');
insert into Breeds (id, breed) values (267, 'Pomsky');
insert into Breeds (id, breed) values (268, 'Poodle');
insert into Breeds (id, breed) values (269, 'Portuguese Podengo');
insert into Breeds (id, breed) values (270, 'Portuguese Water Dog');
insert into Breeds (id, breed) values (271, 'Presa Canario');
insert into Breeds (id, breed) values (272, 'Pug');
insert into Breeds (id, breed) values (273, 'Puggle');
insert into Breeds (id, breed) values (274, 'Puli');
insert into Breeds (id, breed) values (275, 'Pumi');
insert into Breeds (id, breed) values (276, 'Pyrenean Shepherd');
insert into Breeds (id, breed) values (277, 'Rat Terrier');
insert into Breeds (id, breed) values (278, 'Redbone Coonhound');
insert into Breeds (id, breed) values (279, 'Retriever');
insert into Breeds (id, breed) values (280, 'Rhodesian Ridgeback');
insert into Breeds (id, breed) values (281, 'Rottweiler');
insert into Breeds (id, breed) values (282, 'Rough Collie');
insert into Breeds (id, breed) values (283, 'Saint Bernard');
insert into Breeds (id, breed) values (284, 'Saluki');
insert into Breeds (id, breed) values (285, 'Samoyed');
insert into Breeds (id, breed) values (286, 'Sarplaninac');
insert into Breeds (id, breed) values (287, 'Schipperke');
insert into Breeds (id, breed) values (288, 'Schnauzer');
insert into Breeds (id, breed) values (289, 'Schnoodle');
insert into Breeds (id, breed) values (290, 'Scottish Deerhound');
insert into Breeds (id, breed) values (291, 'Scottish Terrier');
insert into Breeds (id, breed) values (292, 'Sealyham Terrier');
insert into Breeds (id, breed) values (293, 'Setter');
insert into Breeds (id, breed) values (294, 'Shar-Pei');
insert into Breeds (id, breed) values (295, 'Sheep Dog');
insert into Breeds (id, breed) values (296, 'Sheepadoodle');
insert into Breeds (id, breed) values (297, 'Shepherd');
insert into Breeds (id, breed) values (298, 'Shetland Sheepdog');
insert into Breeds (id, breed) values (299, 'Shiba Inu');
insert into Breeds (id, breed) values (300, 'Shih poo');
insert into Breeds (id, breed) values (301, 'Shih Tzu');
insert into Breeds (id, breed) values (302, 'Shollie');
insert into Breeds (id, breed) values (303, 'Siberian Husky');
insert into Breeds (id, breed) values (304, 'Silky Terrier');
insert into Breeds (id, breed) values (305, 'Skye Terrier');
insert into Breeds (id, breed) values (306, 'Sloughi');
insert into Breeds (id, breed) values (307, 'Smooth Collie');
insert into Breeds (id, breed) values (308, 'Smooth Fox Terrier');
insert into Breeds (id, breed) values (309, 'South Russian Ovtcharka');
insert into Breeds (id, breed) values (310, 'Spaniel');
insert into Breeds (id, breed) values (311, 'Spanish Water Dog');
insert into Breeds (id, breed) values (312, 'Spinone Italiano');
insert into Breeds (id, breed) values (313, 'Spitz');
insert into Breeds (id, breed) values (314, 'Staffordshire Bull Terrier');
insert into Breeds (id, breed) values (315, 'Standard Poodle');
insert into Breeds (id, breed) values (316, 'Standard Schnauzer');
insert into Breeds (id, breed) values (317, 'Sussex Spaniel');
insert into Breeds (id, breed) values (318, 'Swedish Vallhund');
insert into Breeds (id, breed) values (319, 'Tennessee Treeing Brindle');
insert into Breeds (id, breed) values (320, 'Terrier');
insert into Breeds (id, breed) values (321, 'Thai Ridgeback');
insert into Breeds (id, breed) values (322, 'Tibetan Mastiff');
insert into Breeds (id, breed) values (323, 'Tibetan Spaniel');
insert into Breeds (id, breed) values (324, 'Tibetan Terrier');
insert into Breeds (id, breed) values (325, 'Tosa Inu');
insert into Breeds (id, breed) values (326, 'Toy Fox Terrier');
insert into Breeds (id, breed) values (327, 'Toy Manchester Terrier');
insert into Breeds (id, breed) values (328, 'Treeing Walker Coonhound');
insert into Breeds (id, breed) values (329, 'Vizsla');
insert into Breeds (id, breed) values (330, 'Weimaraner');
insert into Breeds (id, breed) values (331, 'Welsh Springer Spaniel');
insert into Breeds (id, breed) values (332, 'Welsh Terrier');
insert into Breeds (id, breed) values (333, 'West Highland White Terrier');
insert into Breeds (id, breed) values (334, 'Wheaten Terrier');
insert into Breeds (id, breed) values (335, 'Whippet');
insert into Breeds (id, breed) values (336, 'White German Shepherd');
insert into Breeds (id, breed) values (337, 'Wire Fox Terrier');
insert into Breeds (id, breed) values (338, 'Wirehaired Dachshund');
insert into Breeds (id, breed) values (339, 'Wirehaired Pointing Griffon');
insert into Breeds (id, breed) values (340, 'Wirehaired Terrier');
insert into Breeds (id, breed) values (341, 'Xoloitzcuintli');
insert into Breeds (id, breed) values (342, 'Yellow Labrador Retriever');
insert into Breeds (id, breed) values (343, 'Yorkshire Terrier');

insert into Pets_Colors (id, color) values (1, 'Amber');
insert into Pets_Colors (id, color) values (2, 'Black');
insert into Pets_Colors (id, color) values (3, 'Blue');
insert into Pets_Colors (id, color) values (4, 'Yellow');
insert into Pets_Colors (id, color) values (5, 'Brown');
insert into Pets_Colors (id, color) values (6, 'Chocolate');
insert into Pets_Colors (id, color) values (7, 'Cinnamon');
insert into Pets_Colors (id, color) values (8, 'Cream');
insert into Pets_Colors (id, color) values (9, 'Fown');
insert into Pets_Colors (id, color) values (10, 'Isabella');
insert into Pets_Colors (id, color) values (11, 'Lilac');
insert into Pets_Colors (id, color) values (12, 'Pale Amber');
insert into Pets_Colors (id, color) values (13, 'Red');
insert into Pets_Colors (id, color) values (14, 'TortoiseShell');
