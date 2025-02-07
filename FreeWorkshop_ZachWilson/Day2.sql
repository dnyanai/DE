-- there are corrections to the table players and a more optimized way of inserting data into the tables as follows:

-- delete the Day 1 table players:
DROP TABLE players;

-- Create table with the missing column/attribute is_active :
CREATE TABLE players
(
    player_name             TEXT,
    height                  TEXT,
    college                 TEXT,
    country                 TEXT,
    draft_year              TEXT,
    draft_round             TEXT,
    draft_number            TEXT,
    season_stats            season_stats[],
    scoring_class           scoring_class,
    years_since_last_season INTEGER,
    is_active               BOOLEAN,
    current_season          INTEGER,
    PRIMARY KEY (player_name, current_season));

SELECT * FROM players;

-- Already present from Day 1: -- CREATE TYPE scoring_class as ENUM ('star', 'good', 'average', 'bad');

-- Optimized way of inserting into players:

INSERT INTO players

WITH years AS (
    SELECT *
    FROM generate_series(1996, 2022) AS season
),
     p AS (
         SELECT
             player_name,
             MIN(season) AS first_season
         FROM  player_seasons
         GROUP BY player_name)
-- ,
-- players_and_seasons AS (
--
--
--
--
-- )