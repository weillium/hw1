-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy
-- - Movie data includes the movie title, year released, MPAA rating,
--   and director
-- - A movie has a single director
-- - A person can be the director of and/or play a role in a movie
-- - Everything you need to do in this assignment is marked with TODO!

-- Rubric
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
--   (10 points)
-- - Insertion of "Batman" sample data into tables (5 points)
-- - Selection of data, so that something similar to the following sample
--   "report" can be achieved (5 points)

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Christopher Nolan
-- The Dark Knight        2008           PG-13  Christopher Nolan
-- The Dark Knight Rises  2012           PG-13  Christopher Nolan

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movie_cast;

-- Create new tables, according to your domain model
-- TODO!
CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    year_released INTEGER,
    mpaa_rating TEXT, 
    director_name TEXT
);

CREATE TABLE actors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT
);

CREATE TABLE movie_cast (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role TEXT,
    pay INTEGER,
    movie_id INTEGER,
    actor_id INTEGER
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!
INSERT INTO movies 
    (title, year_released, mpaa_rating, director_name)
VALUES
    ("Batman Begins", "2005", "PG-13", "Christopher Nolan"),
    ("The Dark Knight", "2008", "PG-13", "Christopher Nolan"),
    ("The Dark Knight Rises", "2012", "PG-13", "Christopher Nolan");

INSERT INTO actors
    (first_name, last_name)
VALUES
    ("Christian", "Bale"),
    ("Michael", "Caine"),
    ("Liam", "Neeson"),
    ("Katie", "Holmes"),
    ("Gary", "Oldman"),
    ("Heath", "Ledger"),
    ("Aaron", "Eckhart"),
    ("Maggie", "Gyllenhaal"),
    ("Tom", "Hardy"),
    ("Joseph", "Gordon-Levitt"),
    ("Anne", "Hathaway");

INSERT INTO movie_cast
    (role, pay, movie_id, actor_id)
VALUES
    ("Bruce Wayne", 5, 1, 1),
    ("Alfred", 4, 1, 2),
    ("Ra's Al Ghul", 3, 1, 3),
    ("Rachel Dawes", 2, 1, 4),
    ("Commissioner Gordon", 1, 1, 5),
    ("Bruce Wayne", 5, 2, 1),
    ("Joker ", 4, 2, 6),
    ("Harvey Dent", 3, 2, 7),
    ("Alfred ", 2, 2, 2),
    ("Rachel Dawes", 1, 2, 8),
    ("Bruce Wayne", 5, 3, 1),
    ("Commissioner Gordon", 4, 3, 5),
    ("Bane ", 3, 3, 9),
    ("John Blake", 2, 3, 10),
    ("Selina Kyle", 1, 3, 11);

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
SELECT
    title,
    mpaa_rating,
    year_released, 
    director_name
FROM
    movies
ORDER BY
    year_released ASC;

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""

-- The SQL statement for the cast output
SELECT
    movies.title,
    actors.first_name || " " || actors.last_name,
    movie_cast.role
FROM movies
    INNER JOIN movie_cast ON movies.id = movie_cast.movie_id
    INNER JOIN actors ON actors.id = movie_cast.actor_id
ORDER BY movies.id ASC, movie_cast.pay DESC;