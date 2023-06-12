/*Queries that provide answers to the questions from all projects.*/
-- Query 1: Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- Query 2: List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- Query 3: List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
-- Query 4: List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
-- Query 5: List name and escape attempts of animals that weigh more than 10.5kg
SELECT name  escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Query 6: Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;
-- Query 7: Find all animals that not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';
-- Query 8: Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*Vet clinic database: query and update animals table*/
-- Query 1: update the animals table by setting the species column to unspecified
UPDATE animals SET species = 'unspecified';
-- Query 2: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
ROLLBACK;
SELECT COUNT(*) FROM animals WHERE species = 'digimon';
-- Query 3: Update the animals table by setting the species column to pokemon for  all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'pokemon' WHERE species='';
ROLLBACK;
SELECT COUNT(*) FROM animals WHERE species = '';
-- Query 4:  Inside a transaction delete all records in the animals table then rollback
   BEGIN;

   DELETE FROM animals WHERE ;
   SELECT COUNT(*) FROM ANIMALS;

   ROLLBACK;
   SELECT COUNT(*) FROM ANIMALS;
-- Query 5: Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- Query 6: Create a savepoint for the transaction.
SAVEPOINT delete_animals;
-- Query 7: Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;
-- Query 8: Update all animals' weights that are negative to be their weight multiplied by -1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Query 9: How many animals are there?
SELECT COUNT(*) FROM animals;
-- Query 10: How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- Query 11: What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Query 12: Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;
-- Query 13: What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- Query 14: What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
/*-------------------Query of multiple tables ----------------------------------------*/
--What animals belong to Melody Pond?
SELECT *
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';
--List of all animals that are pokemon (their type is Pokemon)
SELECT * 
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name= 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT * 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id;
--How many animals are there per species?
SELECT species.name, COUNT(animals.id) AS animal_count
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;
--List all Digimon owned by Jennifer Orwell.
SELECT *
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;
--List all animals owned by Dean Winchester that haven't tried to escape
SELECT *
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
INNER JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;
/*-------------------Query of Join table visits ----------------------------------------*/
--Who was the last animal seen by William Tatcher?
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher';
--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id)
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';
--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;
--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
--What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.id) AS visit_count
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;
--Who was Maisy Smith's first visit?
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
ORDER BY visits.date_of_visit
LIMIT 1;
--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;
--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.id)
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN specializations ON vets.id = specializations.vet_id
WHERE specializations.species_id != animals.species_id;
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.id) AS visit_count
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN specializations ON vets.id = specializations.vet_id
INNER JOIN species ON specializations.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
LIMIT 1;

-- Perfomance query analysis
EXPLAIN ANALYSE SELECT * FROM owners where email = 'owner_18327@mail.com';
