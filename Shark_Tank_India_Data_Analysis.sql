-- Title: Shark Tank India Data Analysis using MySQL
/* The given dataset contains two tables related to the pitches in Shark Tank India. */

-- 1. Information contained in the first table:
SELECT * FROM sharktankindia.1;

-- 2. Information contained in the second table:
SELECT * FROM sharktankindia.2;

-- 3. Brands and ideas in which maximum amount was invested:
SELECT Brand, Idea, Investment_Amount_inlakhs 
FROM sharktankindia.1
WHERE Investment_Amount_inlakhs IN 
								(SELECT MAX(Investment_Amount_inlakhs) FROM sharktankindia.1);
                                
-- 4. Brands and ideas in which there was no investment:
SELECT Brand, Idea
FROM sharktankindia.1
WHERE Investment_Amount_inlakhs = 0
LIMIT 10;

-- 5. Pitches in which debt was more than 20 lakhs:
SELECT Pitch_Number, Brand, Idea
FROM sharktankindia.1
WHERE Debt_inlakhs > 20;

-- 6. Pitches in which there was some equity:
SELECT Pitch_Number, Equity
FROM sharktankindia.1
WHERE Equity <> 0;

-- 7. Number of pitches in which Ashneer invested, but Namita did not:
SELECT COUNT(Pitch_Number) AS Number_of_pitches
FROM sharktankindia.2
WHERE Ashneer = 'Y' AND Namita = 'N';

-- 8. Number of pitches in which no Shark invested:
SELECT COUNT(Pitch_Number) AS Number_of_pitches
FROM sharktankindia.2
WHERE Anupam = 'N' AND Ashneer = 'N' AND Namita = 'N' AND Aman = 'N' AND Peyush = 'N' AND Vineeta = 'N' AND Ghazal = 'N';

-- 9. Pitches and ideas in which no Shark invested:
SELECT sharktankindia.1.Pitch_Number, sharktankindia.1.Idea
FROM sharktankindia.1
INNER JOIN sharktankindia.2
ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number
WHERE Anupam = 'N' AND Ashneer = 'N' AND Namita = 'N' AND Aman = 'N' AND Peyush = 'N' AND Vineeta = 'N' AND Ghazal = 'N';

-- 10. Brands in which Vineeta invested:
SELECT sharktankindia.1.Brand, sharktankindia.1.Investment_Amount_inlakhs
FROM sharktankindia.1
INNER JOIN sharktankindia.2
ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number
WHERE Vineeta = 'Y'
ORDER BY Investment_Amount_inlakhs DESC;

-- 12. Number of pitches in which all Sharks invested:
SELECT COUNT(Pitch_Number) AS Number_of_pitches
FROM sharktankindia.2
WHERE Anupam = 'Y' AND Ashneer = 'Y' AND Namita = 'Y' AND Aman = 'Y' AND Peyush = 'Y' AND Vineeta = 'Y' AND Ghazal = 'Y';

-- 13. Total amount invested in all the pitches:
SELECT SUM(Investment_Amount_inlakhs) AS Total_investment_amount_inlakhs
FROM sharktankindia.1;

-- 14. Maximum amount invested in each episode:
SELECT Episode_Number, MAX(Investment_Amount_inlakhs) AS Maximum_amount_invested_in_lakhs
FROM sharktankindia.1
GROUP BY Episode_Number;

-- 15. To check if there is any Brand and Idea in which Ashneer, Vineeta and Anupam did not invest:
SELECT Brand, Idea
FROM sharktankindia.1
WHERE EXISTS (SELECT Ashneer, Anupam, Vineeta FROM sharktankindia.2 WHERE sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number AND Ashneer = 'N' AND Vineeta = 'N' AND Anupam = 'N');

-- 16. Debt information in different brands and ideas:
SELECT Brand, Idea,
CASE
    WHEN Debt_inlakhs > 0 THEN 'Debt was considered'
    ELSE 'There was no debt'
END AS Debt_info
FROM sharktankindia.1;

-- 17. Pitches in which ideas involve App:
SELECT Pitch_Number, Idea
FROM sharktankindia.1
WHERE Idea LIKE "%App";

-- 18. Total investment contribution of each Shark Tank:
SELECT 
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Ghazal = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Ghazal, 
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Anupam = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Anupam,
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Ashneer = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Ashneer,
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Namita = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Namita,
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Aman = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Aman,
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Peyush = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Peyush,
 ROUND(CONCAT((SELECT SUM(sharktankindia.1.Investment_Amount_inlakhs) FROM sharktankindia.1 INNER JOIN sharktankindia.2 ON sharktankindia.1.Pitch_Number = sharktankindia.2.Pitch_Number WHERE sharktankindia.2.Vineeta = 'Y')*100/SUM(sharktankindia.1.Investment_Amount_inlakhs), "%"), 0) AS Investment_Percentage_by_Vineeta
FROM sharktankindia.1;

