WITH soil_intersection AS (
    SELECT
        lp.property_u,
        st.soil,
        (ST_Area(ST_Intersection(lp.geom, st.geom))) AS area
    FROM land_prop AS lp
    JOIN soil_type AS st ON (ST_Area(ST_Intersection(lp.geom, st.geom)) > 0)),


soil_area_sum AS (SELECT property_u, soil, SUM(area) AS area
	 FROM soil_intersection 
	 GROUP BY property_u, soil),
	 

highest_area AS (SELECT * FROM soil_area_sum 
	 WHERE NOT EXISTS
	 (SELECT 1 FROM soil_area_sum AS x2 
	 WHERE x2.property_u = soil_area_sum.property_u
	 AND x2.soil <> soil_area_sum.soil
	 AND x2.area > soil_area_sum.area)
	 ORDER BY soil_area_sum.property_u),

tot_prop_sum AS (SELECT property_u, SUM(area) AS area
	 FROM soil_area_sum 
	 GROUP BY property_u),

final_table AS (SELECT 
				ha.property_u,
				ha.soil,
				ha.area AS max_soil_area,
				tps.area AS total_soil_area,
				ha.area / tps.area AS max_soil_fraqtion
				FROM highest_area AS ha
				JOIN tot_prop_sum AS tps ON ha.property_u = tps.property_u)

SELECT * INTO results_table FROM final_table;

SELECT * INTO land_prop_copy FROM land_prop;

ALTER TABLE land_prop_copy
ADD COLUMN dom_soil VARCHAR(64),
ADD COLUMN dom_soil_area FLOAT,
ADD COLUMN dom_soil_fraq FLOAT;

UPDATE land_prop_copy AS lpc
SET dom_soil = rt.soil,
dom_soil_area = rt.max_soil_area,
dom_soil_fraq = rt.max_soil_fraqtion
FROM results_table AS rt
WHERE lpc.property_u = rt.property_u;
	
