INSTALL zipfs FROM community; LOAD zipfs;
INSTALL cache_httpfs FROM community; LOAD cache_httpfs;

SET zipfs_split = '!!';
CREATE TABLE taxon AS FROM read_csv('zip://https://ipt.artsdatabanken.no/archive.do?r=artsnavnebase!!taxon.txt');
CREATE TABLE vernacular_name AS FROM read_csv('zip://https://ipt.artsdatabanken.no/archive.do?r=artsnavnebase!!vernacularname.txt');