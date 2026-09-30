-- Database (Block 1 → Database + Tables)
DROP DATABASE IF EXISTS esports_tournament_db;

CREATE DATABASE esports_tournament_db;

USE esports_tournament_db;


-- Table 
CREATE TABLE game (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    game_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    developer VARCHAR(100),
    platform VARCHAR(50)
);

CREATE TABLE organizer (
    organizer_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    country VARCHAR(50)
);

CREATE TABLE venue (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    capacity INT
);

CREATE TABLE tournament (
    tournament_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_name VARCHAR(150) NOT NULL,
    game_id INT NOT NULL,
    organizer_id INT NOT NULL,
    venue_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    prize_pool DECIMAL(12,2) DEFAULT 0.00,
    status VARCHAR(30) DEFAULT 'Upcoming',
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (organizer_id) REFERENCES organizer(organizer_id),
    FOREIGN KEY (venue_id) REFERENCES venue(venue_id)
);

CREATE TABLE team (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50),
    region VARCHAR(50),
    founded_date DATE,
    team_status VARCHAR(30) DEFAULT 'Active'
);

CREATE TABLE player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(100) NOT NULL,
    ign VARCHAR(50) NOT NULL UNIQUE,
    date_of_birth DATE,
    country VARCHAR(50),
    role VARCHAR(50),
    join_date DATE,
    player_status VARCHAR(30) DEFAULT 'Active'
);

CREATE TABLE team_player (
    team_player_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT NOT NULL,
    player_id INT NOT NULL,
    join_date DATE NOT NULL,
    leave_date DATE,
    position VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (team_id) REFERENCES team(team_id),
    FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE registration (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    team_id INT NOT NULL,
    registration_date DATE NOT NULL,
    registration_status VARCHAR(30) DEFAULT 'Pending',
    seed_number INT,
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE round (
    round_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    round_name VARCHAR(100) NOT NULL,
    round_number INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
);

CREATE TABLE `match` (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    round_id INT NOT NULL,
    match_date DATE NOT NULL,
    match_time TIME,
    venue_id INT,
    match_status VARCHAR(30) DEFAULT 'Scheduled',
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
    FOREIGN KEY (round_id) REFERENCES round(round_id),
    FOREIGN KEY (venue_id) REFERENCES venue(venue_id)
);

CREATE TABLE match_team (
    match_team_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    side VARCHAR(30),
    score INT DEFAULT 0,
    result VARCHAR(20),
    FOREIGN KEY (match_id) REFERENCES `match`(match_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE player_statistics (
    statistic_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    kills INT DEFAULT 0,
    deaths INT DEFAULT 0,
    assists INT DEFAULT 0,
    damage DECIMAL(10,2) DEFAULT 0.00,
    gold DECIMAL(10,2) DEFAULT 0.00,
    mvp_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (match_id) REFERENCES `match`(match_id)
);

CREATE TABLE team_statistics (
    team_stat_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT NOT NULL,
    tournament_id INT NOT NULL,
    matches_played INT DEFAULT 0,
    wins INT DEFAULT 0,
    losses INT DEFAULT 0,
    points INT DEFAULT 0,
    win_rate DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (team_id) REFERENCES team(team_id),
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
);

CREATE TABLE prize (
    prize_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    position INT NOT NULL,
    prize_amount DECIMAL(12,2) NOT NULL,
    prize_type VARCHAR(50),
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
);

CREATE TABLE prize_distribution (
    distribution_id INT PRIMARY KEY AUTO_INCREMENT,
    prize_id INT NOT NULL,
    team_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATE,
    payment_status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (prize_id) REFERENCES prize(prize_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE sponsor (
    sponsor_id INT PRIMARY KEY AUTO_INCREMENT,
    sponsor_name VARCHAR(100) NOT NULL,
    contact VARCHAR(100),
    sponsorship_type VARCHAR(100),
    amount DECIMAL(12,2) DEFAULT 0.00
);

CREATE TABLE tournament_sponsor (
    tournament_sponsor_id INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id INT NOT NULL,
    sponsor_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    sponsorship_date DATE,
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
    FOREIGN KEY (sponsor_id) REFERENCES sponsor(sponsor_id)
);

SHOW TABLES;






-- Game data(Block 2 → Insert Data)
INSERT INTO game (game_name, genre, developer, platform) VALUES
('Mobile Legends: Bang Bang','MOBA','Moonton','Mobile'),
('PUBG Mobile','Battle Royale','Krafton','Mobile'),
('Free Fire','Battle Royale','Garena','Mobile'),
('Valorant','FPS','Riot Games','PC'),
('Counter Strike 2','FPS','Valve','PC'),
('Dota 2','MOBA','Valve','PC'),
('League of Legends','MOBA','Riot Games','PC'),
('EA FC 25','Sports','EA Sports','PC');


-- Organizer data
INSERT INTO organizer (organizer_name,email,phone,country) VALUES
('Bangladesh Esports Federation','bef@gmail.com','01711000001','Bangladesh'),
('Gaming Arena BD','arena@gmail.com','01711000002','Bangladesh'),
('Dhaka Esports League','del@gmail.com','01711000003','Bangladesh'),
('Global Gaming Network','ggn@gmail.com','01711000004','Bangladesh'),
('NextGen Esports','nextgen@gmail.com','01711000005','Bangladesh'),
('Pro Gaming Association','pga@gmail.com','01711000006','Bangladesh'),
('Asia Esports Hub','aeh@gmail.com','01711000007','Bangladesh'),
('Digital Sports BD','dsbd@gmail.com','01711000008','Bangladesh');


-- Venue data
INSERT INTO venue (venue_name,address,city,capacity) VALUES
('Bashundhara Convention Hall','Bashundhara R/A','Dhaka',3000),
('International Convention City','Purbachal','Dhaka',5000),
('Army Stadium','Banani','Dhaka',8000),
('Bangabandhu Hall','Mirpur','Dhaka',2500),
('Chittagong Arena','Agrabad','Chittagong',3000),
('Sylhet Gaming Center','Zindabazar','Sylhet',1500),
('Rajshahi Digital Arena','Boalia','Rajshahi',1800),
('Khulna Esports Hall','Sonadanga','Khulna',2000);


-- Tournament data
INSERT INTO tournament
(tournament_name,game_id,organizer_id,venue_id,start_date,end_date,prize_pool,status) VALUES
('Bangladesh MLBB Championship 2026',1,1,1,'2026-01-10','2026-01-20',1000000,'Completed'),
('PUBG Mobile National Cup 2026',2,2,2,'2026-02-05','2026-02-15',1500000,'Completed'),
('Free Fire Bangladesh Cup 2026',3,3,3,'2026-03-01','2026-03-10',800000,'Completed'),
('Valorant Dhaka Masters 2026',4,4,1,'2026-04-05','2026-04-15',1200000,'Completed'),
('CS2 Pro League Bangladesh',5,5,4,'2026-05-01','2026-05-15',1100000,'Completed'),
('Dota 2 Summer Championship',6,6,5,'2026-06-05','2026-06-20',1300000,'Completed'),
('League of Legends BD Cup',7,7,6,'2026-07-01','2026-07-12',900000,'Completed'),
('EA FC Bangladesh Open',8,8,7,'2026-08-01','2026-08-10',600000,'Completed'),
('MLBB National League Season 2',1,1,2,'2026-10-01','2026-10-15',1800000,'Upcoming'),
('Asia Mobile Esports Championship',1,7,3,'2026-11-05','2026-11-20',2500000,'Upcoming');


-- Team data
INSERT INTO team
(team_name,country,region,founded_date,team_status) VALUES
('Prime Strikers','Bangladesh','Dhaka','2025-01-10','Active'),
('Falcon Esports','Bangladesh','Dhaka','2024-03-15','Active'),
('Red Dragons','Bangladesh','Chittagong','2023-06-20','Active'),
('Titan Warriors','Bangladesh','Dhaka','2022-08-12','Active'),
('Nova Gaming','Bangladesh','Sylhet','2024-01-18','Active'),
('Shadow Hunters','Bangladesh','Rajshahi','2023-11-05','Active'),
('Phoenix Rising','Bangladesh','Dhaka','2022-04-25','Active'),
('Storm Breakers','Bangladesh','Khulna','2024-07-14','Active'),
('Cyber Wolves','Bangladesh','Dhaka','2023-02-11','Active'),
('Infinity Gaming','Bangladesh','Chittagong','2022-09-30','Active'),
('Black Hawks','Bangladesh','Dhaka','2025-02-14','Active'),
('Royal Titans','Bangladesh','Sylhet','2023-05-17','Active'),
('Galaxy Force','Bangladesh','Dhaka','2024-06-01','Active'),
('Elite Warriors','Bangladesh','Rajshahi','2023-10-10','Active'),
('Digital Kings','Bangladesh','Khulna','2024-09-09','Active'),
('Alpha Squad','Bangladesh','Dhaka','2025-03-03','Active'),
('Omega Force','Bangladesh','Chittagong','2024-12-12','Active'),
('Vortex Gaming','Bangladesh','Dhaka','2023-07-07','Active'),
('Next Level','Bangladesh','Sylhet','2025-04-04','Active'),
('Rapid Fire','Bangladesh','Dhaka','2024-08-08','Active');


-- Player data
INSERT INTO player
(player_name,ign,date_of_birth,country,role,join_date,player_status) VALUES
('Arafat Rahman','ARx','2003-01-12','Bangladesh','Jungler','2025-02-01','Active'),
('Sakib Hasan','SakibX','2002-05-18','Bangladesh','Gold Lane','2025-02-01','Active'),
('Tanvir Ahmed','TNV','2004-03-20','Bangladesh','Roamer','2025-02-01','Active'),
('Rakib Hossain','RKB','2003-07-15','Bangladesh','EXP Lane','2025-02-01','Active'),
('Fahim Khan','FahimPro','2002-11-25','Bangladesh','Mid Lane','2025-02-01','Active'),
('Nayeem Islam','NayeemX','2004-02-10','Bangladesh','Jungler','2025-03-01','Active'),
('Rafi Ahmed','RafiOP','2003-06-14','Bangladesh','Gold Lane','2025-03-01','Active'),
('Shuvo Das','Shuvo','2002-09-22','Bangladesh','Roamer','2025-03-01','Active'),
('Mehedi Hasan','MH7','2004-04-16','Bangladesh','EXP Lane','2025-03-01','Active'),
('Imran Hossain','ImranX','2003-12-05','Bangladesh','Mid Lane','2025-03-01','Active'),
('Siam Ahmed','SiamPro','2002-01-19','Bangladesh','Jungler','2025-04-01','Active'),
('Jahid Hasan','JahidX','2003-05-27','Bangladesh','Gold Lane','2025-04-01','Active'),
('Foysal Ahmed','Foysal','2004-08-11','Bangladesh','Roamer','2025-04-01','Active'),
('Arman Hossain','ArmanOP','2003-10-30','Bangladesh','EXP Lane','2025-04-01','Active'),
('Rahat Khan','Rahat','2002-06-06','Bangladesh','Mid Lane','2025-04-01','Active'),
('Sabbir Ahmed','SabbirX','2003-03-13','Bangladesh','Jungler','2025-05-01','Active'),
('Hasan Mahmud','HasanPro','2004-07-21','Bangladesh','Gold Lane','2025-05-01','Active'),
('Adnan Karim','Adnan','2002-10-09','Bangladesh','Roamer','2025-05-01','Active'),
('Munna Islam','MunnaX','2003-02-28','Bangladesh','EXP Lane','2025-05-01','Active'),
('Tareq Rahman','Tareq','2004-05-05','Bangladesh','Mid Lane','2025-05-01','Active'),
('Rony Ahmed','RonyX','2002-12-12','Bangladesh','Jungler','2025-06-01','Active'),
('Masud Rana','Masud','2003-08-18','Bangladesh','Gold Lane','2025-06-01','Active'),
('Nabil Hasan','Nabil','2004-01-25','Bangladesh','Roamer','2025-06-01','Active'),
('Jubair Ahmed','JubairX','2003-04-14','Bangladesh','EXP Lane','2025-06-01','Active'),
('Rasel Khan','Rasel','2002-07-07','Bangladesh','Mid Lane','2025-06-01','Active'),
('Sakib Rahman','SRX','2004-09-09','Bangladesh','Jungler','2025-07-01','Active'),
('Mahin Ahmed','Mahin','2003-11-11','Bangladesh','Gold Lane','2025-07-01','Active'),
('Noman Hossain','Noman','2002-02-22','Bangladesh','Roamer','2025-07-01','Active'),
('Shakil Ahmed','ShakilX','2004-06-16','Bangladesh','EXP Lane','2025-07-01','Active'),
('Riyad Hasan','Riyad','2003-09-19','Bangladesh','Mid Lane','2025-07-01','Active');


-- Team player data
INSERT INTO team_player
(team_id,player_id,join_date,position,is_active) VALUES
(1,1,'2025-02-01','Jungler',TRUE),
(1,2,'2025-02-01','Gold Lane',TRUE),
(1,3,'2025-02-01','Roamer',TRUE),
(1,4,'2025-02-01','EXP Lane',TRUE),
(1,5,'2025-02-01','Mid Lane',TRUE),
(2,6,'2025-03-01','Jungler',TRUE),
(2,7,'2025-03-01','Gold Lane',TRUE),
(2,8,'2025-03-01','Roamer',TRUE),
(2,9,'2025-03-01','EXP Lane',TRUE),
(2,10,'2025-03-01','Mid Lane',TRUE),
(3,11,'2025-04-01','Jungler',TRUE),
(3,12,'2025-04-01','Gold Lane',TRUE),
(3,13,'2025-04-01','Roamer',TRUE),
(3,14,'2025-04-01','EXP Lane',TRUE),
(3,15,'2025-04-01','Mid Lane',TRUE),
(4,16,'2025-05-01','Jungler',TRUE),
(4,17,'2025-05-01','Gold Lane',TRUE),
(4,18,'2025-05-01','Roamer',TRUE),
(4,19,'2025-05-01','EXP Lane',TRUE),
(4,20,'2025-05-01','Mid Lane',TRUE),
(5,21,'2025-06-01','Jungler',TRUE),
(5,22,'2025-06-01','Gold Lane',TRUE),
(5,23,'2025-06-01','Roamer',TRUE),
(5,24,'2025-06-01','EXP Lane',TRUE),
(5,25,'2025-06-01','Mid Lane',TRUE),
(6,26,'2025-07-01','Jungler',TRUE),
(6,27,'2025-07-01','Gold Lane',TRUE),
(6,28,'2025-07-01','Roamer',TRUE),
(6,29,'2025-07-01','EXP Lane',TRUE),
(6,30,'2025-07-01','Mid Lane',TRUE);


-- Registration data
INSERT INTO registration
(tournament_id,team_id,registration_date,registration_status,seed_number) VALUES
(1,1,'2026-01-01','Approved',1),
(1,2,'2026-01-01','Approved',2),
(1,3,'2026-01-02','Approved',3),
(1,4,'2026-01-02','Approved',4),
(2,5,'2026-01-20','Approved',1),
(2,6,'2026-01-20','Approved',2),
(2,7,'2026-01-21','Approved',3),
(2,8,'2026-01-21','Approved',4),
(3,9,'2026-02-15','Approved',1),
(3,10,'2026-02-15','Approved',2),
(3,11,'2026-02-16','Approved',3),
(3,12,'2026-02-16','Approved',4),
(4,13,'2026-03-20','Approved',1),
(4,14,'2026-03-20','Approved',2),
(4,15,'2026-03-21','Approved',3),
(4,16,'2026-03-21','Approved',4),
(5,17,'2026-04-15','Approved',1),
(5,18,'2026-04-15','Approved',2),
(5,19,'2026-04-16','Approved',3),
(5,20,'2026-04-16','Approved',4);


-- Round data
INSERT INTO round
(tournament_id,round_name,round_number,start_date,end_date) VALUES
(1,'Quarter Final',1,'2026-01-10','2026-01-12'),
(1,'Semi Final',2,'2026-01-14','2026-01-15'),
(1,'Grand Final',3,'2026-01-18','2026-01-20'),
(2,'Quarter Final',1,'2026-02-05','2026-02-08'),
(2,'Semi Final',2,'2026-02-10','2026-02-12'),
(2,'Grand Final',3,'2026-02-14','2026-02-15'),
(3,'Quarter Final',1,'2026-03-01','2026-03-04'),
(3,'Semi Final',2,'2026-03-06','2026-03-08'),
(3,'Grand Final',3,'2026-03-09','2026-03-10'),
(4,'Quarter Final',1,'2026-04-05','2026-04-08'),
(4,'Semi Final',2,'2026-04-10','2026-04-12'),
(4,'Grand Final',3,'2026-04-14','2026-04-15');


-- Match data
INSERT INTO `match`
(tournament_id,round_id,match_date,match_time,venue_id,match_status) VALUES
(1,1,'2026-01-10','18:00:00',1,'Completed'),
(1,1,'2026-01-11','18:00:00',1,'Completed'),
(1,2,'2026-01-14','19:00:00',1,'Completed'),
(1,3,'2026-01-18','20:00:00',1,'Completed'),
(2,4,'2026-02-05','18:00:00',2,'Completed'),
(2,4,'2026-02-06','18:00:00',2,'Completed'),
(2,5,'2026-02-10','19:00:00',2,'Completed'),
(2,6,'2026-02-14','20:00:00',2,'Completed'),
(3,7,'2026-03-01','18:00:00',3,'Completed'),
(3,7,'2026-03-02','18:00:00',3,'Completed'),
(3,8,'2026-03-06','19:00:00',3,'Completed'),
(3,9,'2026-03-09','20:00:00',3,'Completed'),
(4,10,'2026-04-05','18:00:00',1,'Completed'),
(4,10,'2026-04-06','18:00:00',1,'Completed'),
(4,11,'2026-04-10','19:00:00',1,'Completed'),
(4,12,'2026-04-14','20:00:00',1,'Completed');


-- Match team data
INSERT INTO match_team
(match_id,team_id,side,score,result) VALUES
(1,1,'Blue',2,'Win'),
(1,2,'Red',1,'Loss'),
(2,3,'Blue',2,'Win'),
(2,4,'Red',0,'Loss'),
(3,1,'Blue',2,'Win'),
(3,3,'Red',1,'Loss'),
(4,1,'Blue',3,'Win'),
(4,3,'Red',2,'Loss'),
(5,5,'Blue',2,'Win'),
(5,6,'Red',0,'Loss'),
(6,7,'Blue',2,'Win'),
(6,8,'Red',1,'Loss'),
(7,5,'Blue',2,'Win'),
(7,7,'Red',1,'Loss'),
(8,5,'Blue',3,'Win'),
(8,7,'Red',2,'Loss'),
(9,9,'Blue',2,'Win'),
(9,10,'Red',1,'Loss'),
(10,11,'Blue',2,'Win'),
(10,12,'Red',0,'Loss'),
(11,9,'Blue',2,'Win'),
(11,11,'Red',1,'Loss'),
(12,9,'Blue',3,'Win'),
(12,11,'Red',2,'Loss'),
(13,13,'Blue',2,'Win'),
(13,14,'Red',1,'Loss'),
(14,15,'Blue',2,'Win'),
(14,16,'Red',0,'Loss'),
(15,13,'Blue',2,'Win'),
(15,15,'Red',1,'Loss'),
(16,13,'Blue',3,'Win'),
(16,15,'Red',2,'Loss');


-- Player statistics data
INSERT INTO player_statistics
(player_id,match_id,kills,deaths,assists,damage,gold,mvp_status) VALUES
(1,1,12,3,8,18500,12500,TRUE),
(2,1,8,4,10,16000,11800,FALSE),
(3,1,3,2,15,9000,10500,FALSE),
(4,1,7,5,9,14000,11000,FALSE),
(5,1,9,4,12,15500,12000,FALSE),
(6,5,14,3,7,21000,13000,TRUE),
(7,5,9,5,11,17000,11900,FALSE),
(8,5,4,2,16,9500,10800,FALSE),
(9,5,8,6,8,14500,11200,FALSE),
(10,5,10,4,13,17500,12100,FALSE),
(11,9,13,2,9,20500,12800,TRUE),
(12,9,10,4,10,18000,12000,FALSE),
(13,9,5,3,17,10000,10900,FALSE),
(14,9,8,5,9,15000,11400,FALSE),
(15,9,11,4,12,19000,12300,FALSE),
(16,13,15,3,8,22000,13200,TRUE),
(17,13,10,5,12,18000,12100,FALSE),
(18,13,4,2,18,9800,11000,FALSE),
(19,13,9,6,10,15500,11500,FALSE),
(20,13,12,4,13,19500,12500,FALSE);


-- Team statistics data
INSERT INTO team_statistics
(team_id,tournament_id,matches_played,wins,losses,points,win_rate) VALUES
(1,1,3,3,0,9,100),
(2,1,1,0,1,0,0),
(3,1,3,1,2,3,33.33),
(4,1,1,0,1,0,0),
(5,2,3,3,0,9,100),
(6,2,1,0,1,0,0),
(7,2,3,1,2,3,33.33),
(8,2,1,0,1,0,0),
(9,3,3,3,0,9,100),
(10,3,1,0,1,0,0),
(11,3,3,1,2,3,33.33),
(12,3,1,0,1,0,0),
(13,4,3,3,0,9,100),
(14,4,1,0,1,0,0),
(15,4,3,1,2,3,33.33),
(16,4,1,0,1,0,0);


-- Prize data
INSERT INTO prize
(tournament_id,position,prize_amount,prize_type) VALUES
(1,1,500000,'Champion'),
(1,2,250000,'Runner Up'),
(1,3,125000,'Third Place'),
(2,1,750000,'Champion'),
(2,2,375000,'Runner Up'),
(2,3,187500,'Third Place'),
(3,1,400000,'Champion'),
(3,2,200000,'Runner Up'),
(3,3,100000,'Third Place'),
(4,1,600000,'Champion'),
(4,2,300000,'Runner Up'),
(4,3,150000,'Third Place');


-- Prize distribution data
INSERT INTO prize_distribution
(prize_id,team_id,amount,payment_date,payment_status) VALUES
(1,1,500000,'2026-01-21','Paid'),
(2,2,250000,'2026-01-21','Paid'),
(3,3,125000,'2026-01-21','Paid'),
(4,5,750000,'2026-02-16','Paid'),
(5,6,375000,'2026-02-16','Paid'),
(6,7,187500,'2026-02-16','Paid'),
(7,9,400000,'2026-03-11','Paid'),
(8,10,200000,'2026-03-11','Paid'),
(9,11,100000,'2026-03-11','Paid'),
(10,13,600000,'2026-04-16','Paid'),
(11,14,300000,'2026-04-16','Paid'),
(12,15,150000,'2026-04-16','Paid');


-- Sponsor data
INSERT INTO sponsor
(sponsor_name,contact,sponsorship_type,amount) VALUES
('Samsung Bangladesh','samsungbd@gmail.com','Technology',500000),
('Grameenphone','gp@gmail.com','Telecommunication',750000),
('Robi Axiata','robi@gmail.com','Telecommunication',600000),
('Red Bull Bangladesh','redbull@gmail.com','Energy Drink',450000),
('Logitech','logitech@gmail.com','Gaming Hardware',400000),
('Razer','razer@gmail.com','Gaming Hardware',350000),
('A4Tech','a4tech@gmail.com','Gaming Hardware',250000),
('Walton','walton@gmail.com','Technology',550000);


-- Tournament sponsor data
INSERT INTO tournament_sponsor
(tournament_id,sponsor_id,amount,sponsorship_date) VALUES
(1,1,500000,'2026-01-05'),
(1,2,300000,'2026-01-06'),
(2,3,500000,'2026-01-25'),
(2,4,300000,'2026-01-26'),
(3,5,300000,'2026-02-20'),
(3,6,200000,'2026-02-21'),
(4,1,400000,'2026-03-25'),
(4,7,200000,'2026-03-26'),
(5,8,500000,'2026-04-20'),
(6,2,600000,'2026-05-20'),
(7,3,400000,'2026-06-20'),
(8,4,250000,'2026-07-20');


-- Data check
SELECT
    (SELECT COUNT(*) FROM game) AS games,
    (SELECT COUNT(*) FROM organizer) AS organizers,
    (SELECT COUNT(*) FROM venue) AS venues,
    (SELECT COUNT(*) FROM tournament) AS tournaments,
    (SELECT COUNT(*) FROM team) AS teams,
    (SELECT COUNT(*) FROM player) AS players;
    
    
    
    
    
    
    
    
    -- Update data(Block 3 → Update + Delete + SELECT)
SET SQL_SAFE_UPDATES = 0;

UPDATE tournament
SET status = 'Ongoing'
WHERE tournament_id = 9;

UPDATE tournament
SET prize_pool = 2000000
WHERE tournament_id = 9;

UPDATE team
SET team_status = 'Inactive'
WHERE team_id = 20;

UPDATE player
SET role = 'Roamer'
WHERE player_id = 1;

UPDATE prize_distribution
SET payment_status = 'Paid',
    payment_date = '2026-09-30'
WHERE distribution_id = 1;

UPDATE sponsor
SET amount = 600000
WHERE sponsor_id = 1;

SET SQL_SAFE_UPDATES = 1;


-- Update check
SELECT * FROM tournament WHERE tournament_id = 9;
SELECT * FROM team WHERE team_id = 20;
SELECT * FROM player WHERE player_id = 1;
SELECT * FROM sponsor WHERE sponsor_id = 1;


-- Delete data
START TRANSACTION;

DELETE FROM registration
WHERE registration_id = 20;

DELETE FROM team_player
WHERE team_player_id = 30;

ROLLBACK;


-- Basic select
SELECT * FROM game;

SELECT game_name, genre
FROM game;

SELECT *
FROM tournament
WHERE status = 'Completed';

SELECT tournament_name, prize_pool
FROM tournament
WHERE prize_pool > 1000000;

SELECT *
FROM team
WHERE region = 'Dhaka';

SELECT *
FROM player
WHERE role = 'Roamer';

SELECT *
FROM player
WHERE player_name LIKE 'A%';

SELECT *
FROM tournament
WHERE prize_pool BETWEEN 800000 AND 1500000;

SELECT *
FROM team
WHERE region IN ('Dhaka','Chittagong');

SELECT *
FROM tournament
ORDER BY prize_pool DESC;

SELECT *
FROM player
ORDER BY player_name;

SELECT DISTINCT region
FROM team;

SELECT DISTINCT role
FROM player;

SELECT *
FROM tournament
ORDER BY start_date DESC
LIMIT 5;

SELECT *
FROM team
WHERE team_status = 'Active';









-- Subquery(Block 5 → Subquery + Advanced + View)
SELECT tournament_name, prize_pool
FROM tournament
WHERE prize_pool > (
    SELECT AVG(prize_pool)
    FROM tournament
);

SELECT team_name
FROM team
WHERE team_id IN (
    SELECT team_id
    FROM team_statistics
    WHERE wins >= 3
);

SELECT player_name, ign
FROM player
WHERE player_id IN (
    SELECT player_id
    FROM player_statistics
    WHERE kills > (
        SELECT AVG(kills)
        FROM player_statistics
    )
);

SELECT tournament_name, prize_pool
FROM tournament
WHERE prize_pool = (
    SELECT MAX(prize_pool)
    FROM tournament
);

SELECT player_name, ign
FROM player
WHERE player_id IN (
    SELECT player_id
    FROM player_statistics
    WHERE mvp_status = TRUE
);


-- Advanced
SELECT
    tournament_name,
    prize_pool,
    CASE
        WHEN prize_pool >= 2000000 THEN 'Very High'
        WHEN prize_pool >= 1000000 THEN 'High'
        WHEN prize_pool >= 700000 THEN 'Medium'
        ELSE 'Low'
    END AS prize_category
FROM tournament;

SELECT
    p.player_name,
    ps.kills,
    ps.deaths,
    ROUND(ps.kills / NULLIF(ps.deaths,0),2) AS kd_ratio
FROM player p
INNER JOIN player_statistics ps
ON p.player_id = ps.player_id;

SELECT
    p.player_name,
    ps.kills,
    ps.assists,
    (ps.kills + ps.assists) AS contribution
FROM player p
INNER JOIN player_statistics ps
ON p.player_id = ps.player_id
ORDER BY contribution DESC;

SELECT
    t.tournament_name,
    COUNT(r.registration_id) AS registered_teams
FROM tournament t
LEFT JOIN registration r
ON t.tournament_id = r.tournament_id
GROUP BY t.tournament_id, t.tournament_name;

SELECT
    p.player_name,
    SUM(ps.kills) AS total_kills,
    SUM(ps.deaths) AS total_deaths,
    SUM(ps.assists) AS total_assists
FROM player p
INNER JOIN player_statistics ps
ON p.player_id = ps.player_id
GROUP BY p.player_id, p.player_name
ORDER BY total_kills DESC;

SELECT
    t.team_name,
    SUM(ts.wins) AS wins,
    SUM(ts.losses) AS losses,
    SUM(ts.points) AS points
FROM team t
INNER JOIN team_statistics ts
ON t.team_id = ts.team_id
GROUP BY t.team_id, t.team_name
ORDER BY points DESC;


-- View
CREATE OR REPLACE VIEW tournament_overview AS
SELECT
    t.tournament_id,
    t.tournament_name,
    g.game_name,
    o.organizer_name,
    v.venue_name,
    t.start_date,
    t.end_date,
    t.prize_pool,
    t.status
FROM tournament t
INNER JOIN game g
ON t.game_id = g.game_id
INNER JOIN organizer o
ON t.organizer_id = o.organizer_id
LEFT JOIN venue v
ON t.venue_id = v.venue_id;

SELECT * FROM tournament_overview;


-- View
CREATE OR REPLACE VIEW team_performance AS
SELECT
    t.team_id,
    t.team_name,
    ts.matches_played,
    ts.wins,
    ts.losses,
    ts.points,
    ts.win_rate
FROM team t
INNER JOIN team_statistics ts
ON t.team_id = ts.team_id;

SELECT * FROM team_performance;


-- View
CREATE OR REPLACE VIEW player_performance AS
SELECT
    p.player_id,
    p.player_name,
    p.ign,
    p.role,
    SUM(ps.kills) AS total_kills,
    SUM(ps.deaths) AS total_deaths,
    SUM(ps.assists) AS total_assists
FROM player p
INNER JOIN player_statistics ps
ON p.player_id = ps.player_id
GROUP BY
    p.player_id,
    p.player_name,
    p.ign,
    p.role;

SELECT * FROM player_performance;










-- Procedure(Block 6 → Procedure + Function + Cursor + Trigger + Transaction)
DROP PROCEDURE IF EXISTS GetTournamentByStatus;

DELIMITER //

CREATE PROCEDURE GetTournamentByStatus(
    IN tournament_status VARCHAR(30)
)
BEGIN
    SELECT
        tournament_id,
        tournament_name,
        prize_pool,
        status
    FROM tournament
    WHERE status = tournament_status;
END //

DELIMITER ;

CALL GetTournamentByStatus('Completed');


-- Procedure
DROP PROCEDURE IF EXISTS GetTeamPlayers;

DELIMITER //

CREATE PROCEDURE GetTeamPlayers(
    IN team_id_input INT
)
BEGIN
    SELECT
        t.team_name,
        p.player_name,
        p.ign,
        tp.position
    FROM team_player tp
    INNER JOIN team t
    ON tp.team_id = t.team_id
    INNER JOIN player p
    ON tp.player_id = p.player_id
    WHERE tp.team_id = team_id_input;
END //

DELIMITER ;

CALL GetTeamPlayers(1);


-- Function
DROP FUNCTION IF EXISTS GetPlayerKDRatio;

DELIMITER //

CREATE FUNCTION GetPlayerKDRatio(
    player_id_input INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE kd_ratio DECIMAL(10,2);

    SELECT
        ROUND(SUM(kills) / NULLIF(SUM(deaths),0),2)
    INTO kd_ratio
    FROM player_statistics
    WHERE player_id = player_id_input;

    RETURN IFNULL(kd_ratio,0);
END //

DELIMITER ;

SELECT
    player_id,
    player_name,
    GetPlayerKDRatio(player_id) AS kd_ratio
FROM player;


-- Function
DROP FUNCTION IF EXISTS GetTournamentPrize;

DELIMITER //

CREATE FUNCTION GetTournamentPrize(
    tournament_id_input INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total_prize DECIMAL(12,2);

    SELECT SUM(prize_amount)
    INTO total_prize
    FROM prize
    WHERE tournament_id = tournament_id_input;

    RETURN IFNULL(total_prize,0);
END //

DELIMITER ;

SELECT
    tournament_id,
    tournament_name,
    GetTournamentPrize(tournament_id) AS total_prize
FROM tournament;


-- Cursor
DROP PROCEDURE IF EXISTS ShowHighPrizeTournaments;

DELIMITER //

CREATE PROCEDURE ShowHighPrizeTournaments()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE t_name VARCHAR(150);
    DECLARE t_prize DECIMAL(12,2);

    DECLARE tournament_cursor CURSOR FOR
        SELECT tournament_name, prize_pool
        FROM tournament
        WHERE prize_pool >= 1000000;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN tournament_cursor;

    read_loop: LOOP

        FETCH tournament_cursor
        INTO t_name, t_prize;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT
            t_name AS tournament_name,
            t_prize AS prize_pool;

    END LOOP;

    CLOSE tournament_cursor;
END //

DELIMITER ;

CALL ShowHighPrizeTournaments();


-- Trigger
DROP TRIGGER IF EXISTS before_team_insert;

DELIMITER //

CREATE TRIGGER before_team_insert
BEFORE INSERT ON team
FOR EACH ROW
BEGIN
    IF NEW.team_status IS NULL THEN
        SET NEW.team_status = 'Active';
    END IF;
END //

DELIMITER ;


-- Trigger test
INSERT INTO team
(team_name,country,region,founded_date)
VALUES
('Test Esports Team','Bangladesh','Dhaka','2026-01-01');

SELECT *
FROM team
WHERE team_name = 'Test Esports Team';

DELETE FROM team
WHERE team_name = 'Test Esports Team';


-- Transaction
START TRANSACTION;

UPDATE tournament
SET prize_pool = prize_pool + 100000
WHERE tournament_id = 9;

SELECT
    tournament_id,
    tournament_name,
    prize_pool
FROM tournament
WHERE tournament_id = 9;

ROLLBACK;


-- Transaction commit
START TRANSACTION;

UPDATE sponsor
SET amount = amount + 50000
WHERE sponsor_id = 1;

COMMIT;

SELECT *
FROM sponsor
WHERE sponsor_id = 1;


-- Final check
SHOW TABLES;