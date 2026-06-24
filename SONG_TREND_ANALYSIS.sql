use trend;
-- 1.  – Find the top 10 songs with the highest number of weeks on the chart.
select 
track_name , 
MAX(weeks_on_chart_in_dataset) as tot_weeks 
from songs 
group by track_name 
order by tot_weeks desc limit 47 ;

-- 2. Which songs stayed on the chart for the longest period?
select 
    track_name,
    artist_names,
    lifetime_weeks_on_chart
from songs
order by lifetime_weeks_on_chart desc limit 10;

-- 3) Which songs reached their peak rank the fastest?
SELECT
    track_name,
    artist_names,
    peak_rank,
    weeks_on_chart_in_dataset,
    lifetime_weeks_on_chart
FROM songs
ORDER BY weeks_on_chart_in_dataset ASC, peak_rank ASC;

-- 4) Which songs had the highest total streams overall?
select track_name ,total_streams from songs 
order by total_streams desc limit 10;

-- 5) Which songs showed the biggest drop from peak week to last appearance?
SELECT
    track_name,
    artist_names,
    peak_rank,
    last_appearance_rank,
    (last_appearance_rank - peak_rank) AS rank_drop
FROM songs
ORDER BY rank_drop DESC;

-- 6) Which songs improved the most in rank compared to the previous week?
SELECT
    track_name,
    artist_names,
    previous_rank,
    peak_rank,
    (previous_rank - peak_rank) AS rank_improvement
FROM songs
WHERE previous_rank IS NOT NULL
ORDER BY rank_improvement DESC
LIMIT 10;

-- 7) Which artists had the most charting songs in the dataset?
SELECT 
    artist_names,
    COUNT(*) AS total_charting_songs
FROM songs
GROUP BY artist_names
ORDER BY total_charting_songs DESC
LIMIT 20;

-- 8) Which songs had the strongest early performance but weak ending performance?
SELECT 
    track_name,
    artist_names,
    peak_rank,
    last_appearance_rank,
    (last_appearance_rank - peak_rank) AS rank_drop
FROM songs
WHERE peak_rank <= 20                    -- peaked in top 20
  AND last_appearance_rank >= 50         -- exited weakly
ORDER BY rank_drop DESC
LIMIT 20;

-- 9) Which songs were stable across their chart lifetime with little rank change?
SELECT 
    track_name,
    artist_names,
    peak_rank,
    last_appearance_rank,
    lifetime_weeks_on_chart,
    ABS(last_appearance_rank - peak_rank) AS rank_volatility
FROM songs
WHERE lifetime_weeks_on_chart >= 4       -- enough weeks to assess stability
ORDER BY rank_volatility ASC
LIMIT 20;

-- 10) How to categorize songs into lifecycle patterns using their chart performance metrics
SELECT
    track_name,
    artist_names,
    peak_rank,
    last_appearance_rank,
    weeks_on_chart_in_dataset,
    lifetime_weeks_on_chart,
    total_streams,

    CASE

        -- Flash Hit
        WHEN peak_rank <= 10
             AND last_appearance_rank >= 50
             AND lifetime_weeks_on_chart <= 8
        THEN 'Flash Hit'

        -- Sustained Peak
        WHEN peak_rank <= 10
             AND last_appearance_rank <= 30
             AND lifetime_weeks_on_chart >= 10
        THEN 'Sustained Peak'

        -- Revival
        WHEN last_appearance_rank < peak_rank
             AND lifetime_weeks_on_chart >= 5
        THEN 'Revival'

        -- Slow Burn
        WHEN peak_rank > 10
             AND lifetime_weeks_on_chart >= 10
        THEN 'Slow Burn'

        -- Remaining Songs
        ELSE 'Standard'

    END AS lifecycle_pattern

FROM songs;

-- 11) Which source or label had the most songs with long chart lifetimes?
SELECT 
    source,
    COUNT(*) AS total_songs,
    COUNT(CASE WHEN lifetime_weeks_on_chart >= 8 THEN 1 END) AS long_lived_songs,
    ROUND(
        100.0 * COUNT(CASE WHEN lifetime_weeks_on_chart >= 8 THEN 1 END) / COUNT(*), 
        1
    ) AS long_lived_pct,
    ROUND(AVG(lifetime_weeks_on_chart), 1) AS avg_lifetime_weeks
FROM songs
GROUP BY source
HAVING COUNT(*) >= 3                    -- filter out sources with only 1-2 songs
ORDER BY long_lived_songs DESC;

--  12) Which artists have the most songs appearing in the dataset?
SELECT 
    artist_names,
    COUNT(*) AS total_songs
FROM songs
GROUP BY artist_names
ORDER BY total_songs DESC
LIMIT 20;

-- 13) How many songs reached the peak rank of #1?
SELECT 
    track_name,
    artist_names,
    peak_week_streams,
    lifetime_weeks_on_chart
FROM songs
WHERE peak_rank = 1
ORDER BY peak_week_streams DESC;

-- 14) What is the average lifetime of songs across different sources/platforms?
SELECT 
    source,
    COUNT(*)                                    AS total_songs,
    ROUND(AVG(lifetime_weeks_on_chart), 1)      AS avg_lifetime_weeks,
    ROUND(AVG(weeks_on_chart_in_dataset), 1)    AS avg_weeks_in_dataset,
    MAX(lifetime_weeks_on_chart)                AS longest_chart_run
FROM songs
GROUP BY source
ORDER BY avg_lifetime_weeks DESC;

-- 15) Which songs showed the biggest improvement in ranking compared to their previous rank?
SELECT 
    track_name,
    artist_names,
    previous_rank,
    peak_rank,
    (previous_rank - peak_rank) AS rank_jump
FROM songs
WHERE previous_rank IS NOT NULL
  AND previous_rank > peak_rank          -- only actual improvements
ORDER BY rank_jump DESC
LIMIT 20;

-- 16) How many songs remained on the chart for more than 50 or 100 weeks?
SELECT 
    track_name,
    artist_names,
    source,
    lifetime_weeks_on_chart,
    CASE 
        WHEN lifetime_weeks_on_chart > 100 THEN '100+ weeks'
        WHEN lifetime_weeks_on_chart > 50  THEN '50–100 weeks'
    END AS longevity_tier
FROM songs
WHERE lifetime_weeks_on_chart > 50
ORDER BY lifetime_weeks_on_chart DESC;

-- 17) What is the average number of weeks songs stayed in the dataset?
SELECT 
    ROUND(AVG(weeks_on_chart_in_dataset), 1)   AS avg_weeks_in_dataset,
    ROUND(AVG(lifetime_weeks_on_chart), 1)      AS avg_lifetime_weeks,
    MIN(weeks_on_chart_in_dataset)              AS min_weeks,
    MAX(weeks_on_chart_in_dataset)              AS max_weeks,
    COUNT(*)                                    AS total_songs
FROM songs;

-- 18) Which artists achieved the best average peak rank?
SELECT 
    artist_names,
    COUNT(*)                        AS total_songs,
    ROUND(AVG(peak_rank), 1)        AS avg_peak_rank,
    MIN(peak_rank)                  AS best_peak,
    COUNT(CASE WHEN peak_rank = 1 THEN 1 END) AS number_one_hits
FROM songs
GROUP BY artist_names
HAVING COUNT(*) >= 2                -- at least 2 songs to make average meaningful
ORDER BY avg_peak_rank ASC          -- ASC because rank 1 is best
LIMIT 20;

-- 19) Which songs appeared multiple times in the dataset?
SELECT 
    track_name,
    artist_names,
    SUM(weeks_on_chart_in_dataset) AS total_weeks_in_dataset
FROM songs
GROUP BY track_name, artist_names
HAVING COUNT(*) > 1
ORDER BY total_weeks_in_dataset DESC;

-- 20) How many songs belong to each source/platform?
SELECT 
    source,
    COUNT(*)                                            AS total_songs,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1)  AS pct_of_total
FROM songs
GROUP BY source
ORDER BY total_songs DESC;

-- 21) Find the top 10 songs by total streams accumulated across all their appearances.
select track_name , MAX(total_streams) as streams from songs group by track_name order by streams desc limit 10;

-- 22) Find all songs that reached number one at any point.
select distinct track_name,peak_rank
from songs
where peak_rank = 1;

-- 23) Find Songs that stayed on chart the most weeks
select
    track_name,
    lifetime_weeks_on_chart
from songs
order by lifetime_weeks_on_chart desc, total_streams desc;

-- 24) Find Songs that reached peak rank the fastest
select
    track_name,
    peak_rank,
    weeks_on_chart_in_dataset
from songs
order by weeks_on_chart_in_dataset asc, peak_rank asc;

-- 25) **Seasonal Debut Patterns** – Count the number of new song debuts in each calendar month.
SELECT 
    MONTHNAME(DATE_SUB(last_appearance_date, INTERVAL (lifetime_weeks_on_chart - 1) WEEK)) AS debut_month,
    MONTH(DATE_SUB(last_appearance_date, INTERVAL (lifetime_weeks_on_chart - 1) WEEK))      AS month_number,
    COUNT(*) AS new_debuts
FROM songs
GROUP BY 1, 2
ORDER BY month_number;

