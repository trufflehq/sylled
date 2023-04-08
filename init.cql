CREATE KEYSPACE kune WITH REPLICATION = {
	'class': 'NetworkTopologyStrategy',
	'replication_factor': 2
};

USE kune;

CREATE TABLE episode (
  id uuid,
  show_name text,
  show_id int,
  title text,
  season int,
  episode int,
  year int,
  PRIMARY KEY (id)
);

CREATE MATERIALIZED VIEW episode_by_show AS
  SELECT id, show_name, show_id, title, season, episode, year
  FROM episode
  WHERE show_name IS NOT NULL AND show_id IS NOT NULL
  PRIMARY KEY ((show_name, show_id), id);

CREATE MATERIALIZED VIEW episode_by_year AS
  SELECT id, show_name, show_id, title, season, episode, year
  FROM episode
  WHERE year IS NOT NULL AND id IS NOT NULL
  PRIMARY KEY (year, id);

CREATE MATERIALIZED VIEW episode_by_season AS
  SELECT id, show_name, show_id, title, season, episode, year
  FROM episode
  WHERE season IS NOT NULL AND id IS NOT NULL
  PRIMARY KEY (season, id);

CREATE MATERIALIZED VIEW episode_by_episode AS
  SELECT id, show_name, show_id, title, season, episode, year
  FROM episode
  WHERE episode IS NOT NULL AND id IS NOT NULL
  PRIMARY KEY (episode, id);

INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12493, 'Suits', 172, 'Pilot', 1, 1, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12495, 'Suits', 172, 'Errors and Omissions', 1, 2, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12496, 'Suits', 172, 'Inside Track', 1, 3, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12497, 'Suits', 172, 'Dirty Little Secrets', 1, 4, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12498, 'Suits', 172, 'Bail Out', 1, 5, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12499, 'Suits', 172, 'Tricks of the Trade', 1, 6, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12500, 'Suits', 172, 'Play the Man', 1, 7, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12501, 'Suits', 172, 'Identity Crisis', 1, 8, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12502, 'Suits', 172, 'Undefeated', 1, 9, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12503, 'Suits', 172, 'The Shelf Life', 1, 10, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12504, 'Suits', 172, 'Rules of the Game', 1, 11, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12505, 'Suits', 172, 'Dog Fight', 1, 12, 2011);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12506, 'Suits', 172, 'She Knows', 2, 1, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12507, 'Suits', 172, 'The Choice', 2, 2, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12508, 'Suits', 172, 'Meet the New Boss', 2, 3, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12509, 'Suits', 172, 'Discovery', 2, 4, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12510, 'Suits', 172, 'Break Point', 2, 5, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12511, 'Suits', 172, 'All In', 2, 6, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12512, 'Suits', 172, 'Sucker Punch', 2, 7, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12513, 'Suits', 172, 'Rewind', 2, 8, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12514, 'Suits', 172, 'Asterisk', 2, 9, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12515, 'Suits', 172, 'High Noon', 2, 10, 2012);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12516, 'Suits', 172, 'Blind-Sided', 2, 11, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12517, 'Suits', 172, 'Blood in the Water', 2, 12, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12518, 'Suits', 172, 'Zane vs. Zane', 2, 13, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12519, 'Suits', 172, 'He\'s Back', 2, 14, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12520, 'Suits', 172, 'Normandy', 2, 15, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12521, 'Suits', 172, 'War', 2, 16, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12522, 'Suits', 172, 'The Arrangement', 3, 1, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12523, 'Suits', 172, 'I Want You to Want Me', 3, 2, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12524, 'Suits', 172, 'Unfinished Business', 3, 3, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12525, 'Suits', 172, 'Conflict of Interest', 3, 4, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12526, 'Suits', 172, 'Shadow of a Doubt', 3, 5, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12527, 'Suits', 172, 'The Other Time', 3, 6, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12528, 'Suits', 172, 'She\'s Mine', 3, 7, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12529, 'Suits', 172, 'Endgame', 3, 8, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12530, 'Suits', 172, 'Bad Faith', 3, 9, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12531, 'Suits', 172, 'Stay', 3, 10, 2013);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12532, 'Suits', 172, 'Buried Secrets', 3, 11, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12533, 'Suits', 172, 'Yesterday\'s Gone', 3, 12, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12534, 'Suits', 172, 'Moot Point', 3, 13, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12535, 'Suits', 172, 'Heartburn', 3, 14, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12536, 'Suits', 172, 'Know When to Fold \'Em', 3, 15, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12537, 'Suits', 172, 'No Way Out', 3, 16, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12538, 'Suits', 172, 'One-Two-Three Go...', 4, 1, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12539, 'Suits', 172, 'Breakfast, Lunch and Dinner', 4, 2, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12540, 'Suits', 172, 'Two in the Knees', 4, 3, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12541, 'Suits', 172, 'Leveraged', 4, 4, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12542, 'Suits', 172, 'Pound of Flesh', 4, 5, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12543, 'Suits', 172, 'Litt the Hell Up', 4, 6, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12544, 'Suits', 172, 'We\'re Done', 4, 7, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12545, 'Suits', 172, 'Exposure', 4, 8, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12546, 'Suits', 172, 'Gone', 4, 9, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (12547, 'Suits', 172, 'This Is Rome', 4, 10, 2014);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (57555, 'Suits', 172, 'Enough Is Enough', 4, 11, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (124035, 'Suits', 172, 'Respect', 4, 12, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (124036, 'Suits', 172, 'Fork in the Road', 4, 13, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (124037, 'Suits', 172, 'Derailed', 4, 14, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (124038, 'Suits', 172, 'Intent', 4, 15, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (141816, 'Suits', 172, 'Not Just a Pretty Face', 4, 16, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (153399, 'Suits', 172, 'Denial', 5, 1, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (177751, 'Suits', 172, 'Compensation', 5, 2, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (177752, 'Suits', 172, 'No Refills', 5, 3, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (177753, 'Suits', 172, 'No Puedo Hacerlo', 5, 4, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (177754, 'Suits', 172, 'Toe to Toe', 5, 5, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (189615, 'Suits', 172, 'Privilege', 5, 6, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (201011, 'Suits', 172, 'Hitting Home', 5, 7, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (202073, 'Suits', 172, 'Mea Culpa', 5, 8, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (202850, 'Suits', 172, 'Uninvited Guests', 5, 9, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (203890, 'Suits', 172, 'Faith', 5, 10, 2015);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (426794, 'Suits', 172, 'Blowback', 5, 11, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (570459, 'Suits', 172, 'Live to Fight', 5, 12, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (570460, 'Suits', 172, 'God\'s Green Earth', 5, 13, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (570461, 'Suits', 172, 'Self Defense', 5, 14, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (570462, 'Suits', 172, 'Tick Tock', 5, 15, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (570463, 'Suits', 172, '25th Hour', 5, 16, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (774411, 'Suits', 172, 'To Trouble', 6, 1, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830861, 'Suits', 172, 'Accounts Payable', 6, 2, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830862, 'Suits', 172, 'Back on the Map', 6, 3, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830863, 'Suits', 172, 'Turn', 6, 4, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830864, 'Suits', 172, 'Trust', 6, 5, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830865, 'Suits', 172, 'Spain', 6, 6, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830866, 'Suits', 172, 'Shake the Trees', 6, 7, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830867, 'Suits', 172, 'Borrowed Time', 6, 8, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830868, 'Suits', 172, 'The Hand That Feeds You', 6, 9, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (830869, 'Suits', 172, 'P.S.L.', 6, 10, 2016);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (979416, 'Suits', 172, 'She\'s Gone', 6, 11, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1041932, 'Suits', 172, 'The Painting', 6, 12, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1046530, 'Suits', 172, 'Teeth, Nose, Teeth', 6, 13, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1047339, 'Suits', 172, 'Admission of Guilt', 6, 14, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1047340, 'Suits', 172, 'Quid Pro Quo', 6, 15, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1047341, 'Suits', 172, 'Character and Fitness', 6, 16, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1160583, 'Suits', 172, 'Skin in the Game', 7, 1, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1160584, 'Suits', 172, 'The Statue', 7, 2, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1160585, 'Suits', 172, 'Mudmare', 7, 3, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1216912, 'Suits', 172, 'Divide and Conquer', 7, 4, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1250221, 'Suits', 172, 'Brooklyn Housing', 7, 5, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1264540, 'Suits', 172, 'Home to Roost', 7, 6, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1264541, 'Suits', 172, 'Full Disclosure', 7, 7, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1264542, 'Suits', 172, '100', 7, 8, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1283575, 'Suits', 172, 'Shame', 7, 9, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1263650, 'Suits', 172, 'Donna', 7, 10, 2017);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1401379, 'Suits', 172, 'Hard Truths', 7, 11, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1418683, 'Suits', 172, 'Bad Man', 7, 12, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1428453, 'Suits', 172, 'Inevitable', 7, 13, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1437050, 'Suits', 172, 'Pulling the Goalie', 7, 14, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1445931, 'Suits', 172, 'Tiny Violin', 7, 15, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1445932, 'Suits', 172, 'Good-Bye', 7, 16, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1472225, 'Suits', 172, 'Right-Hand Man', 8, 1, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1494751, 'Suits', 172, 'Pecking Order', 8, 2, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1496611, 'Suits', 172, 'Promises, Promises', 8, 3, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1501670, 'Suits', 172, 'Revenue Per Square Foot', 8, 4, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1508236, 'Suits', 172, 'Good Mudding', 8, 5, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1508706, 'Suits', 172, 'Cats, Ballet, Harvey Specter', 8, 6, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1514601, 'Suits', 172, 'Sour Grapes', 8, 7, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1516228, 'Suits', 172, 'Coral Gables', 8, 8, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1521673, 'Suits', 172, 'Motion to Delay', 8, 9, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1521832, 'Suits', 172, 'Managing Partner', 8, 10, 2018);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1587195, 'Suits', 172, 'Rocky 8', 8, 11, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1589780, 'Suits', 172, 'Whale Hunt', 8, 12, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1596960, 'Suits', 172, 'The Greater Good', 8, 13, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1601417, 'Suits', 172, 'Peas in a Pod', 8, 14, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1605634, 'Suits', 172, 'Stalking Horse', 8, 15, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1605635, 'Suits', 172, 'Harvey', 8, 16, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1648832, 'Suits', 172, 'Everything\'s Changed', 9, 1, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1678136, 'Suits', 172, 'Special Master', 9, 2, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1684219, 'Suits', 172, 'Windmills', 9, 3, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1684220, 'Suits', 172, 'Cairo', 9, 4, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1691223, 'Suits', 172, 'If the Shoe Fits', 9, 5, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1696271, 'Suits', 172, 'Whatever It Takes', 9, 6, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1701899, 'Suits', 172, 'Scenic Route', 9, 7, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1710096, 'Suits', 172, 'Prisoner\'s Dilemma', 9, 8, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1714618, 'Suits', 172, 'Thunder Away', 9, 9, 2019);
INSERT INTO episode (id, show_name, show_id, title, season, episode, year) VALUES (1715345, 'Suits', 172, 'One Last Con', 9, 10, 2019);
