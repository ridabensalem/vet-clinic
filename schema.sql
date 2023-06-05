/* Database schema to keep the structure of entire database. */
/*Creating animals table */

CREATE TABLE animals (
id INTEGER PRIMARY KEY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INTEGER,
neutered BOOLEAN,
weight_kg DOUBLE PRECISION);
