/* Inserting animals data into animals table . */

INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (1,'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (2,'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (3,'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (4,'Devimon', '2017-05-12', 5, true, 11);
--New data
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (5,'Charmander', '2020-02-08', 0, false, -11);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (6,'Plantmon', '2021-11-15', 2, true, -5.7);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (7,'Squirtle', '1993-04-02', 3, false, -12.13);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (8,'Angemon', '2005-06-12', 1, true, -45);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (9,'Boarmon', '2005-06-07', 7, true, 20.4);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (10,'Blossom', '1998-10-13', 3, true, 17);
Insert INTO animals (id,name, date_of_birth, escape_attempts, neutered,weight_kg) VALUES (11,'Ditto', '2022-05-14', 4, true, 22);
/*-------------------Query of multiple tables ----------------------------------------*/
--Insert data into owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);
--Insert data into species table
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');
--Modify inserted animals 
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN 2 
    ELSE 1 
    END;
--Modify inserted owners 
UPDATE animals
SET owner_id=CASE 
WHEN name='Agumon' THEN 1
WHEN name='Gabumon'  OR name='Pickachu' THEN 2
WHEN name='Devimon'  OR name='Plantmon' THEN 3
WHEN name='Charmander'  OR name='Squirtle'  OR name='Blossom' THEN 4
WHEN name='Angemon'  OR name='Boarmon' THEN 5
END; 

