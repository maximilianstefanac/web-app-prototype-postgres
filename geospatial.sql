-- activate postgis extension
CREATE EXTENSION postgis;

CREATE SCHEMA webgis;

CREATE TABLE webgis.tree (
    tree_id INT PRIMARY KEY,
    species VARCHAR(100),
    position GEOMETRY(POINT) NOT NULL
);

-- POINT(x y) -> latitude = x, longitude = y -> WKT Standard
-- POSTGIS needs a SRID for storing geospatial information
INSERT INTO webgis.tree VALUES
    (1, NULL, 'SRID=4326;POINT(8.677202 49.218523)'),
    (2, NULL, 'SRID=4326;POINT(8.677193 49.218400)'),
    (3, NULL, 'SRID=4326;POINT(8.677184 49.218310)'),
    (4, NULL, 'SRID=4326;POINT(8.677112 49.217826)'),
    (5, NULL, 'SRID=4326;POINT(8.677103 49.217069)'),
    (6, NULL, 'SRID=4326;POINT(8.676717 49.216577)');

CREATE TABLE webgis.plot (
    plot_id INT PRIMARY KEY,
    plot_name VARCHAR(100),
    boundary GEOMETRY(POLYGON) NOT NULL 
);

INSERT INTO webgis.plot VALUES
    (1, 'Obst-Gen-Garten', 'SRID=4326;POLYGON((8.677058 49.218531,8.676849 49.216258,8.674748 49.216280,8.674712 49.216217,8.676846 49.216199,8.676861 49.216100,8.677283 49.216188,8.677462 49.218530, 8.677058 49.218531))');

-- ST_Within expects geometry data. geography data has to be casted
SELECT * FROM webgis.tree as t WHERE ST_Within(t.position, (SELECT boundary FROM webgis.plot WHERE plot_id = 1 LIMIT 1));