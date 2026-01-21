-- Galatasaray Management System Database Tables

-- Drop existing tables first (in correct order due to foreign keys)
DROP TABLE IF EXISTS "PlayerMatch";
DROP TABLE IF EXISTS "Match";
DROP TABLE IF EXISTS "Player";
DROP TABLE IF EXISTS "Stadium";  
DROP TABLE IF EXISTS "Team";

-- Create tables with correct EF Core naming
CREATE TABLE "Team" (
    "TeamId" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL
);

CREATE TABLE "Stadium" (
    "StadiumId" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Capacity" INTEGER NOT NULL,
    "TeamId" INTEGER REFERENCES "Team"("TeamId")
);

CREATE TABLE "Player" (
    "PlayerId" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100) NOT NULL,
    "Position" VARCHAR(50) NOT NULL,
    "TeamId" INTEGER REFERENCES "Team"("TeamId")
);

CREATE TABLE "Match" (
    "MatchId" SERIAL PRIMARY KEY,
    "Opponent" VARCHAR(100) NOT NULL,
    "MatchDate" TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE "PlayerMatch" (
    "PlayerId" INTEGER REFERENCES "Player"("PlayerId"),
    "MatchId" INTEGER REFERENCES "Match"("MatchId"),
    "MinutesPlayed" INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY ("PlayerId", "MatchId")
);

-- Insert sample data
INSERT INTO "Team" ("Name") VALUES ('Galatasaray');

INSERT INTO "Stadium" ("Name", "Capacity", "TeamId") 
SELECT 'Rams Park', 52280, t."TeamId" 
FROM "Team" t WHERE t."Name" = 'Galatasaray';

INSERT INTO "Player" ("Name", "Position", "TeamId")
SELECT 'Mauro Icardi', 'Striker', t."TeamId" FROM "Team" t WHERE t."Name" = 'Galatasaray'
UNION ALL
SELECT 'Fernando Muslera', 'Goalkeeper', t."TeamId" FROM "Team" t WHERE t."Name" = 'Galatasaray'  
UNION ALL
SELECT 'Kerem Aktürkoğlu', 'Winger', t."TeamId" FROM "Team" t WHERE t."Name" = 'Galatasaray';

INSERT INTO "Match" ("Opponent", "MatchDate") VALUES 
('Fenerbahçe', '2024-11-15 19:00:00+00'),
('Beşiktaş', '2024-10-15 16:00:00+00'),
('Trabzonspor', '2024-09-15 18:00:00+00');