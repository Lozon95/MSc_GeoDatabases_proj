# MSc Course Project – Dominant Soil Type Analysis with PostGIS

This repository contains an SQL script developed during my MSc studies in Geomatics at Lund University.  
The project demonstrates how to calculate the **dominant soil type per property** using spatial analysis functions in PostGIS.

## 📂 Repository Contents
- `dominant_soil_analysis.sql` – SQL script that:
  - Intersects property polygons with soil type polygons
  - Calculates intersection areas
  - Aggregates soil areas per property
  - Identifies the dominant soil type (largest area)
  - Computes the fraction of the dominant soil relative to total soil area
  - Updates a property table copy with new columns for dominant soil, area, and fraction

## 🔧 Methods
- Spatial intersection with `ST_Intersection`  
- Area calculation with `ST_Area`  
- Aggregation and grouping with SQL CTEs (`WITH ...`)  
- Logic for selecting maximum values using `NOT EXISTS`  
- Table creation and update to integrate results back into the database  

## ⚠️ Note
This script was created as part of coursework and is intended for educational purposes.  
It assumes the existence of two tables: `land_prop` (properties) and `soil_type` (soil polygons).  
Adapt table names and column names as needed for other datasets.

## 🎓 Context
Developed during MSc studies in Geomatics at Lund University as an exercise in advanced SQL and PostGIS spatial analysis.
