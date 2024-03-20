CREATE TABLE olympic_medal_winners (
  olympic_year INT,
  sport        VARCHAR(30),
  gender       VARCHAR(1),
  event        VARCHAR(128),
  medal        VARCHAR(10),
  noc          VARCHAR(3),
  athlete      VARCHAR(128)
);

INSERT INTO olympic_medal_winners (OLYMPIC_YEAR,SPORT,GENDER,EVENT,MEDAL,NOC,ATHLETE)
VALUES
    (2016,'Wrestling','M','Men''s Freestyle 57 kg','Bronze','AZE','ALIYEV Haji'),
    (2016,'Archery','M','Men''s Individual','Gold','KOR','KU Bonchan')
/* далее добавляется массив данных */;


-- Pivot по медалям.
SELECT * FROM crosstab(
  'SELECT noc, medal, count(*) 
   FROM olympic_medal_winners 
   GROUP BY noc, medal 
   ORDER BY noc',
  'SELECT m FROM (VALUES (''Gold''), (''Silver''), (''Bronze'')) AS t(m)'
) AS ct (noc text, "Gold" int, "Silver" int, "Bronze" int)
ORDER BY noc
LIMIT 6;


-- Pivot для уникальных медалей, учитывая дублирование.
SELECT * FROM crosstab(
  'SELECT noc, medal, count(DISTINCT sport || ''#'' || event || ''#'' || gender) 
   FROM olympic_medal_winners 
   GROUP BY noc, medal 
   ORDER BY noc',
  'SELECT m FROM (VALUES (''Gold''), (''Silver''), (''Bronze'')) AS t(m)'
) AS ct (noc text, "Gold" int, "Silver" int, "Bronze" int)
ORDER BY "Gold" DESC, "Silver" DESC, "Bronze" DESC
LIMIT 5;


-- Pivot для стран, начинающихся с "D", с подсчетом уникальных медалей.
SELECT * FROM crosstab(
  'SELECT noc, medal, count(DISTINCT sport || ''#'' || event || ''#'' || gender) 
   FROM olympic_medal_winners 
   WHERE noc LIKE ''D%'' 
   GROUP BY noc, medal 
   ORDER BY noc',
  'SELECT m FROM (VALUES (''Gold'')) AS t(m)'
) AS ct (noc text, "Gold" int)
ORDER BY "Gold" DESC;


-- Pivot для матрицы спортов по странам.
SELECT * FROM crosstab(
  'SELECT noc, sport, ''X'' 
   FROM olympic_medal_winners 
   ORDER BY noc',
  'SELECT s FROM (VALUES (''Archery''), (''Athletics''), (''Hockey''), (''Judo''), (''Sailing''), (''Wrestling'')) AS t(s)'
) AS ct (noc text, "Archery" text, "Athletics" text, "Hockey" text, "Judo" text, "Sailing" text, "Wrestling" text)
ORDER BY noc
LIMIT 7;