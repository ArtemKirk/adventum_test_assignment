SELECT
	hour,
	COUNT(*),
	ROUND(AVG(likes), 2) AS likes
FROM (
	SELECT
		likes,
		EXTRACT(hour FROM date) AS hour
	from posts
)
GROUP BY hour
ORDER BY hour;


SELECT
	weekday,
	COUNT(*),
	ROUND(AVG(likes), 2) AS likes
FROM (
	SELECT
		likes,
		EXTRACT(dow FROM date) AS weekday
	FROM posts
)
GROUP BY weekday
ORDER BY weekday;

SELECT 
	CASE
	WHEN diff < '1 day'::interval THEN '<1 дня'
	WHEN diff < '2 days'::interval THEN '1-2 дня'
	WHEN diff < '6 days'::interval THEN '3-6 дней'
	WHEN diff < '14 days'::interval THEN '7-14 дней'
	ELSE '>14 дней'
	END AS difference,
	COUNT(*),
	ROUND(AVG(likes), 2) AS likes
FROM (
	SELECT
		AGE(date, LEAD(date, -1) OVER(ORDER BY date)) AS diff,
		likes
	FROM posts
)
WHERE diff IS NOT NULL
GROUP BY difference;

	