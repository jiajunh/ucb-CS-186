-- Before running drop any existing views
DROP VIEW IF EXISTS q0;
DROP VIEW IF EXISTS q1i;
DROP VIEW IF EXISTS q1ii;
DROP VIEW IF EXISTS q1iii;
DROP VIEW IF EXISTS q1iv;
DROP VIEW IF EXISTS q2i;
DROP VIEW IF EXISTS q2ii;
DROP VIEW IF EXISTS q2iii;
DROP VIEW IF EXISTS q3i;
DROP VIEW IF EXISTS q3ii;
DROP VIEW IF EXISTS q3iii;
DROP VIEW IF EXISTS q4i;
DROP VIEW IF EXISTS q4ii;
DROP VIEW IF EXISTS q4iii;
DROP VIEW IF EXISTS q4iv;
DROP VIEW IF EXISTS q4v;

-- Question 0
CREATE VIEW q0(era)
AS
  SELECT MAX(era) FROM pitching -- replace this line
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight>300 -- replace this line
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
  ORDER BY namefirst, namelast ASC-- replace this line
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*)
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear ASC -- replace this line
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*)
  FROM people
  GROUP BY birthyear
  HAVING AVG(height)>70
  ORDER BY birthyear ASC -- replace this line
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT P.namefirst, P.namelast, P.playerID, H.yearid
  FROM people AS P, halloffame AS H
  WHERE H.inducted='Y' AND P.playerID=H.playerID
  ORDER BY H.yearid DESC, P.playerID ASC -- replace this line
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT P.namefirst, P.namelast, P.playerID, C.schoolID, H.yearid
  FROM people AS P, halloffame AS H, collegeplaying AS C, schools AS S
  WHERE H.inducted='Y' AND P.playerID=H.playerID AND H.playerID=C.playerID AND C.schoolID=S.schoolID AND S.state='CA'
  ORDER BY H.yearid DESC, C.schoolID, P.playerID ASC -- replace this line
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT P.playerID, P.namefirst, P.namelast, S.schoolID
  FROM people AS P, (
    SELECT H.playerID, C.schoolID, H.inducted
    FROM halloffame AS H 
    LEFT JOIN collegeplaying AS C
    ON H.playerID=C.playerID
  ) AS S
  WHERE S.inducted='Y' AND P.playerID=S.playerID
  ORDER BY P.playerID DESC, S.schoolID ASC -- replace this line
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT P.playerID, P.namefirst, P.namelast, B.yearID, B.slg
  FROM people AS P, (
    SELECT b.playerID, b.yearID, (b.H+b.H2B+2*b.H3B+3*b.HR)*1.0/b.AB AS slg
    FROM batting AS b
    WHERE b.AB>50
  ) as B
  WHERE P.playerID=B.playerID
  ORDER BY B.slg DESC, B.yearID, B.playerID ASC
  LIMIT 0, 10 -- replace this line
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT P.playerID, P.namefirst, P.namelast, B.slgSum*1.0/B.sAb AS lslg
  FROM people AS P, (
    SELECT b.playerID, SUM(b.H+b.H2B+2*b.H3B+3*b.HR) AS slgSum, SUM(b.AB) AS sAb
    FROM batting AS b 
    GROUP BY b.playerID
  ) AS B
  WHERE P.playerID=B.playerID AND B.sAb>50
  ORDER BY lslg DESC, B.playerID ASC
  LIMIT 0, 10 -- replace this line
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT P.namefirst, P.namelast, B.slgSum*1.0/B.sAb AS lslg
  FROM people AS P, (
    SELECT b.playerID, SUM(b.H+b.H2B+2*b.H3B+3*b.HR) AS slgSum, SUM(b.AB) AS sAb
    FROM batting AS b 
    GROUP BY b.playerID
  ) AS B 
  WHERE P.playerID=B.playerID AND B.sAb>50 AND lslg>(
    SELECT SUM(batting.H+batting.H2B+2*batting.H3B+3*batting.HR)*1.0/SUM(batting.AB)
    FROM batting
    WHERE batting.playerID='mayswi01'
    GROUP BY batting.playerID
  )
  ORDER BY lslg DESC, B.playerID ASC-- replace this line
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg)
AS
  SELECT S.yearID, MIN(S.salary), MAX(S.salary), AVG(S.salary)
  FROM salaries AS S
  GROUP BY S.yearID
  ORDER BY S.yearID ASC -- replace this line
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  WITH salaryInfo AS (
    SELECT MIN(salary) AS mins, MAX(salary) AS maxs, (MAX(salary)-MIN(salary))/10 AS range
    FROM salaries
    WHERE yearID='2016'
  ), bin AS (
    SELECT width_bucket(salary, mins, maxs, 10) AS binid, COUNT(*) AS c
    FROM salaries, salaryInfo
    WHERE yearID='2016'
    GROUP BY binid
  )
  SELECT bin.binid, salaryInfo.mins, salaryInfo.maxs, bin.c
  FROM salaryInfo, bin
  ORDER BY bin.binid ASC -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT cur.yearid, cur.min-pre.min, cur.max-pre.max, cur.avg-pre.avg
  FROM q4i AS cur
  INNER JOIN q4i AS pre 
  ON cur.yearid-1=pre.yearid
  ORDER BY cur.yearid ASC -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT P.playerID, P.namefirst, P.namelast, S.salary, S.yearID
  FROM people AS P 
  LEFT JOIN salaries AS S
  ON P.playerID=S.playerID
  WHERE (S.yearID BETWEEN '2000' AND '2001') AND (yearID, salary) IN (
    SELECT yearID, MAX(salary)
    FROM salaries
    GROUP BY yearID
  ) -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT A.teamID, MAX(S.salary)-MIN(S.salary)
  FROM allstarfull AS A
  INNER JOIN salaries AS S
  ON A.playerID=S.playerID AND A.yearID=S.yearID
  WHERE A.yearID='2016'
  GROUP BY A.teamID -- replace this line
;

