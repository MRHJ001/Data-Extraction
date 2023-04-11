--Opened city-hex-polygons-8-10.geojson Edge
--Copied all the records and paste in notpad
--Saved the file as city-hex-polygons-8-10.geojson

Declare @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 'C:\Paty to geojson file\city-hex-polygons-8-10.geojson', SINGLE_CLOB) import

--Insert geojson file into the database
SELECT
	*
into City_Hex_Polygons_8_10_1
FROM
OPENJSON(@JSON, '$.features')

	WITH (
		[index] nvarchar(300) '$.properties.index',
		[centroid_lat] float '$.properties.centroid_lat',
		[centroid_lon] float '$.properties.centroid_lon',
		[resolution] int '$.properties.resolution',
		[type] nvarchar(300) '$.geometry.type',
		[coorGeo] nvarchar(max) '$.geometry.coordinates' as json
	) 

GO


select * 
from City_Hex_Polygons_8_10_1
where resolution = 8


