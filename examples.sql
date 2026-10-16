.print "Look for similar scientific names: gulo gulo"

select taxonID, scientificName, jaro_winkler_similarity(lower(scientificName), 'gulo gulo', 0.9) as score
from taxon
where score > 0
order by score desc, scientificName
limit 5;

.print "Look for similar Bokmål vernacular names: fjellrev"

select taxonID, scientificName, vernacularName,
       jaro_winkler_similarity(vernacularName, 'fjellrev', 0.9) as score
from vernacular_name
join taxon on vernacular_name.id = taxon.taxonID
where language = 'nb' and score > 0
order by score desc, vernacularName
limit 5;

.print "Match the closest Bokmål vernacular name extending example_names.csv"

from 'example_names.csv'
left join lateral (
    select taxonID,
           scientificName,
           vernacularName,
           jaro_winkler_similarity(vernacularName, lower(name), 0.9) AS score
    from vernacular_name
    join taxon on vernacular_name.id = taxon.taxonID
    where language = 'nb' and score > 0
    order by score desc, vernacularName
    limit 1
) on true;
