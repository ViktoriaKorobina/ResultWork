DROP DATABASE IF EXISTS mans_friends;
CREATE DATABASE mans_friends;
USE mans_friends;

DROP TABLE IF EXISTS horses;
CREATE TABLE horses(
horse_id SERIAL PRIMARY KEY, 
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO horses (horse_id, name, command, birth_date) VALUES
(1, 'Ugolek', 'apport', '2015-10-11'),
(2, 'Iskorka', 'apport', '2016-05-06'),
(3, 'Grom', 'apport', '2017-11-12');

DROP TABLE IF EXISTS camels;
CREATE TABLE camels(
camel_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO camels (camel_id, name, command, birth_date) VALUES
(4, 'Deneb', NULL, '2014-11-11'),
(5, 'Bo', NULL, '2013-06-07'),
(6, 'Hloya', NULL, '2018-10-10');


DROP TABLE IF EXISTS donkeys;
CREATE TABLE donkeys(
donkey_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO donkeys (donkey_id, name, command, birth_date) VALUES
(7, 'Pop', NULL, '2018-07-12'),
(8, 'Dora', NULL, '2019-07-08'),
(9, 'Perl', NULL, '2020-10-12');

DROP TABLE IF EXISTS cats;
CREATE TABLE cats(
cat_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO cats (cat_id, name, command, birth_date) VALUES
(1, 'Kusya', 'eat', '2020-05-06'),
(2, 'Kisha', 'eat', '2021-04-10'),
(3, 'Murzik', 'eat', '2020-12-04');

DROP TABLE IF EXISTS dogs;
CREATE TABLE dogs(
dog_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO dogs (dog_id, name, command, birth_date) VALUES
(4, 'Polkan', 'hand', '2021-06-06'),
(5, 'Muhtar', 'lie', '2020-05-10'),
(6, 'Druzhok', 'seat', '2019-11-05');


DROP TABLE IF EXISTS hamsters;
CREATE TABLE hamsters(
hamster_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE);

INSERT INTO hamsters (hamster_id, name, command, birth_date) VALUES
(7, 'Bystrick', NULL, '2024-01-06'),
(8, 'Shustrick', NULL, '2023-12-10'),
(9, 'Shusha', NULL, '2023-05-10');

DROP TABLE IF EXISTS pets;
CREATE TABLE pets(
pet_id SERIAL PRIMARY KEY,
pet_type VARCHAR(50) NOT NULL,
cat_id BIGINT UNSIGNED,
dog_id BIGINT UNSIGNED,
hamster_id BIGINT UNSIGNED,
FOREIGN KEY (cat_id) REFERENCES cats(cat_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (dog_id) REFERENCES dogs(dog_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (hamster_id) REFERENCES hamsters(hamster_id) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO pets(pet_id, pet_type, cat_id, dog_id, hamster_id) VALUES
(1, 'cats', 1, NULL, NULL),
(2, 'cats', 2, NULL, NULL),
(3, 'cats', 3, NULL, NULL),
(4, 'dogs', NULL, 4, NULL),
(5, 'dogs', NULL, 5, NULL),
(6, 'dogs', NULL, 6, NULL),
(7, 'hamsters', NULL, NULL, 7),
(8, 'hamsters', NULL, NULL, 8),
(9, 'hamsters', NULL, NULL, 9);


DROP TABLE IF EXISTS livestocks;
CREATE TABLE livestocks(
livestock_id SERIAL PRIMARY KEY,
livestock_type VARCHAR(50) NOT NULL,
horse_id BIGINT UNSIGNED,
camel_id BIGINT UNSIGNED,
donkey_id BIGINT UNSIGNED,
FOREIGN KEY (horse_id) REFERENCES horses(horse_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (camel_id) REFERENCES camels(camel_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (donkey_id) REFERENCES donkeys(donkey_id) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO livestocks(livestock_id, livestock_type, horse_id, camel_id, donkey_id) VALUES
(1, 'horses', 1, NULL, NULL),
(2, 'horses', 2, NULL, NULL),
(3, 'horses', 3, NULL, NULL),
(4, 'camels', NULL, 4, NULL),
(5, 'camels', NULL, 5, NULL),
(6, 'camels', NULL, 6, NULL),
(7, 'donkeys', NULL, NULL, 7),
(8, 'donkeys', NULL, NULL, 8),
(9, 'donkeys', NULL, NULL, 9);

DELETE FROM camels;

DROP TABLE IF EXISTS equines;
CREATE TABLE equines(
equine_id SERIAL PRIMARY KEY,
name VARCHAR(50),
command VARCHAR(50),
birth_date DATE,
type VARCHAR(50));

INSERT INTO equines (name, command, birth_date, type)
SELECT name, command, birth_date, 'horse' FROM horses;

INSERT INTO equines (name, command, birth_date, type)
SELECT name, command, birth_date, 'donkey' FROM donkeys;



DROP TABLE IF EXISTS young_animals;
CREATE TABLE young_animals(
young_animal_id SERIAL PRIMARY KEY,
name VARCHAR(50),
birth_date DATE,
age_months INT);

INSERT INTO young_animals (name, birth_date, age_months)
SELECT name, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) AS age_months
FROM (
    SELECT name, birth_date FROM horses
    UNION ALL
    SELECT name, birth_date FROM camels
    UNION ALL
    SELECT name, birth_date FROM donkeys
    UNION ALL
    SELECT name, birth_date FROM cats
    UNION ALL
    SELECT name, birth_date FROM dogs
    UNION ALL
    SELECT name, birth_date FROM hamsters
) AS all_animals
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 1 AND 2;

DROP TABLE IF EXISTS all_animals;
CREATE TABLE all_animals (
  animal_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  command VARCHAR(50),
  birth_date DATE,
  type VARCHAR(50),
  original_table VARCHAR(50)
);

INSERT INTO all_animals (name, command, birth_date, type, original_table)
SELECT name, command, birth_date, 'horse', 'horses' FROM horses
UNION ALL
SELECT name, command, birth_date, 'donkey', 'donkeys' FROM donkeys
UNION ALL
SELECT name, command, birth_date,'cat', 'cats' FROM cats
UNION ALL
SELECT name, command, birth_date,'dog', 'dogs' FROM dogs
UNION ALL
SELECT name, command, birth_date,'hamster', 'hamsters' FROM hamsters;


DROP TABLE IF EXISTS animals;
CREATE TABLE animals(
  animal_id SERIAL PRIMARY KEY,
  pet_id BIGINT UNSIGNED,
  livestock_id BIGINT UNSIGNED,
  FOREIGN KEY (pet_id) REFERENCES pets(pet_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (livestock_id) REFERENCES livestocks(livestock_id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO animals (pet_id)
SELECT pet_id FROM pets;

INSERT INTO animals (livestock_id)
SELECT livestock_id FROM livestocks;


