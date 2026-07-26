# Cyclistic Bike-Share Analysis: How Do Annual Members and Casual Riders Use Bikes Differently?

## Overview
This project analyzes historical bike-share trip data for Cyclistic, a fictional bike-share company operating in Chicago, as part of the Google Data Analytics Professional Certificate capstone. The goal is to understand behavioral differences between annual members and casual riders in order to support a marketing strategy aimed at converting casual riders into annual members.

## Business Task
Cyclistic's director of marketing believes the company's future growth depends on maximizing annual memberships, since annual members are more profitable than casual riders. Rather than targeting new customers broadly, the marketing team wants to convert existing casual riders into annual members.

This analysis specifically addresses the first of three guiding questions assigned to the marketing analytics team:

> **How do annual members and casual riders use Cyclistic bikes differently?**

## Data Source
This analysis uses Cyclistic's historical trip data, made publicly available by Motivate International Inc. (operators of the real-world Divvy bike-share system, on which this fictional case study is based).

- **Source:** [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)
- **License:** [Divvy Data License Agreement](https://divvybikes.com/data-license-agreement) — grants a non-exclusive, royalty-free, limited, perpetual license to access, analyze, and use the data for any lawful purpose.
- **Time period covered:** 12 months, July 2025 – June 2026
- **Format:** Monthly `.csv` files, one per month, imported as individual tables into Google BigQuery (dataset: `CyclisticData`, tables `2025-07-Trips` through `2026-06-Trips`)
- **Privacy note:** The dataset does not include personally identifiable rider information, so this analysis cannot connect ride data to individual riders (e.g., whether a casual rider has purchased multiple single-ride passes, or whether they live within the service area).

**Data credibility (ROCCC check):**
- **Reliable:** Sourced directly from the bike-share operator, not a third party
- **Original:** First-party trip-level data, not aggregated or altered by another source
- **Comprehensive:** Covers a full 12-month cycle, capturing seasonal variation
- **Current:** Reflects the most recent 12 months available at the time of analysis
- **Cited:** Publicly documented source and license, linked above

**Tools used:** Google BigQuery (SQL) for data storage, combination, cleaning, and analysis. Tableau for data visualizations.
