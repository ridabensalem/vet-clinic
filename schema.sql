/* Database schema to keep the structure of entire database. */
/*Creating animals table */


CREATE TABLE animals (
id INTEGER PRIMARY KEY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INTEGER,
neutered BOOLEAN,
weight_kg DOUBLE PRECISION);


/*Add a column species of type string to your animals table . */
ALTER TABLE animals ADD COLUMN species VARCHAR(255);
/*-------------------Query of multiple tables ----------------------------------------*/
--Create a table owners with columns id, full_name, age
CREATE TABLE owners(
id SERIAL PRIMARY KEY,
full_name VARCHAR(255),
age INTEGER
);
--Create a table species with columns id, name
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);
--remove column species
ALTER TABLE animals
DROP COLUMN species;
--add column species_id foreign key refrerence to species table
ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species(id);
--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id  INTEGER REFERENCES owners(id);
--create a table vets with columns id, name, age,date_of_graduation
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);
-- Create a "join table" called specializations to handle this relationship
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id)
);
-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    date_of_visit DATE
);
/*-----------------------Database performance --------------------------------*/
-- Add an email column to the  owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
