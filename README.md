# 🎵 Song Trend Lifecycle Analysis

## 📖 Overview

Song success is often measured by its highest chart rank. However, a song reaching Rank #1 for a single week and disappearing shortly afterward is fundamentally different from a song that steadily gains popularity and remains on charts for months.

This project analyzes Spotify India Weekly Charts over a 54-week period to study how songs perform throughout their lifecycle. Using Python, MySQL, and Power BI, songs are classified into lifecycle categories based on chart longevity and performance patterns, providing deeper insights into listener engagement beyond peak rank alone.

---

## 🎯 Objectives

* Analyze song performance across 54 weeks of Spotify India Weekly Charts.
* Measure listener retention using chart longevity.
* Classify songs into lifecycle categories.
* Compare peak chart success with long-term popularity.
* Identify trends among artists, labels, and collaborations.
* Build an interactive dashboard for exploratory analysis.

---

## 📂 Dataset Information

| Attribute         | Value                       |
| ----------------- | --------------------------- |
| Source            | Spotify India Weekly Charts |
| Period            | May 2025 – May 2026         |
| Weekly Files      | 54 CSV Files                |
| Total Records     | 10,798                      |
| Unique Songs      | 635                         |

### Key Fields

* rank
* uri
* track_name
* artist_names
* source
* streams
* previous_rank
* peak_rank
* weeks_on_chart
* chart_date

---

## 🛠️ Tools & Technologies

### Python

* Pandas

### Database

* MySQL

### Visualization

* Power BI

### Development Environment

* Jupyter Notebook
* MySQL Workbench

---

## 🔄 Project Workflow

### 1. Data Collection

* Extracted 54 weekly Spotify chart files.
* Combined all files into a single dataset.

### 2. Data Cleaning

* Removed inconsistencies.
* Standardized column names.
* Validated unique song identifiers.

### 3. Data Aggregation

Created a song-level summary table containing:

* Peak Rank
* Total Streams
* Weeks on Chart
* Peak Week Streams
* Last Appearance Rank
* Last Appearance Streams
* Lifetime Weeks on Chart

### 4. SQL Analysis

Performed analytical queries including:

* Top streamed songs
* Rank #1 songs
* One-week wonders
* Label performance
* Artist performance
* Collaboration analysis
* Lifecycle pattern analysis

### 5. Dashboard Development

Built an interactive Power BI dashboard to visualize:

* Lifecycle distribution
* Artist performance
* Label dominance
* Streaming trends
* Chart longevity patterns

---

## 📊 Lifecycle Classification

Songs were categorized using their chart duration within the dataset.

| Category            | Weeks on Chart |
| ------------------- | -------------- |
| Flash Hit           | 1–4 Weeks      |
| Slow Burn           | 5–12 Weeks     |
| Standard            | 13–30 Weeks    |
| Sustained Peak      | 31–54 Weeks    |

---

## 📈 Key Insights

### Chart Longevity Distribution

* 36.4% of songs were Flash Hits.
* 19.7% were Short-Lived.
* 22.0% were Sustained Performers.
* 21.9% became Evergreen songs.

### Listener Retention

* Median chart duration was approximately 10 weeks.
* Most songs disappeared within a few weeks of debut.

### One-Week Wonders

* 86 songs appeared only once and never returned.

### Evergreen Songs

* 47 songs remained on charts throughout the entire 54-week period.

### Peak Rank vs Longevity

Several songs achieved high chart positions but quickly disappeared, demonstrating that peak rank alone does not fully represent long-term audience engagement.

---

## 🗄️ SQL Analysis Performed

1.Find the top 10 songs with the highest number of weeks on the chart. 

2.Which songs stayed on the chart for the longest period? 
3.Which songs reached their peak rank the fastest? 
4.Which songs had the highest total streams overall? 
5.Which songs showed the biggest drop from peak week to last appearance? 
6.Which songs improved the most in rank compared to the previous week? 
7.Which artists had the most charting songs in the dataset? 
8.Which songs had the strongest early performance but weak ending performance? 
9.Which songs were stable across their chart lifetime with little rank change? 
10.How can songs be categorized into lifecycle patterns using their chart performance metrics? 
11.Which source or label had the most songs with long chart lifetimes? 
12.Which artists have the most songs appearing in the dataset? 
13.How many songs reached the peak rank of #1? 
14.What is the average lifetime of songs across different sources/platforms? 
15.Which songs showed the biggest improvement in ranking compared to their previous rank? 
16.How many songs remained on the chart for more than 50 or 100 weeks? 
17.What is the average number of weeks songs stayed in the dataset? 
18.Which artists achieved the best average peak rank? 
19.Which songs appeared multiple times in the dataset? 
20.How many songs belong to each source/platform? 
21.Find the top 10 songs by total streams accumulated across all their appearances. 
22.Find all songs that reached number one at any point. 
23.Find songs that stayed on the chart the most weeks. 
24.Find songs that reached peak rank the fastest. 
25.Seasonal Debut Patterns – Count the number of new song debuts in each calendar month.

---

## 📊 Dashboard Features

### KPIs

* Total Songs
* Total Streams
* Weeks on Chart
* Peak rank

### Visualizations

* TOP 10 MOST STREAMED  SONGS
* TOP 10 MOST STREAMED   LABELS
* MONTHWISE STREAMS
* PEAK & PREVIOUS RANK 
* TOP 10 SONGS BY WEEKS

### Filters

* Lifecycle Category
* Songs 
* Label
---

## 🎯 Business Value

This project demonstrates how chart longevity can provide insights beyond peak rankings.

Potential applications include:

* Measuring listener retention
* Evaluating marketing effectiveness
* Understanding long-term audience engagement
* Identifying sustainable music trends
* Supporting label and artist performance analysis

---

## ⚠️ Limitations

* Analysis is limited to Spotify India Weekly Charts.
* External factors such as marketing campaigns and social media influence are not included.
* Peak rank alone cannot explain why songs sustain or decline.
* Results may differ across countries and streaming platforms.

---

## 🚀 Project Highlights

✔ Processed 10,798 chart records

✔ Consolidated 54 weekly datasets

✔ Aggregated 635 unique songs

✔ Performed advanced SQL analysis

✔ Developed lifecycle classification framework

✔ Built interactive Power BI dashboard

✔ Generated actionable insights on song longevity and listener retention



This project is intended for educational and portfolio purposes. Spotify chart data belongs to its respective owners and was used solely for analytical learning and research.
