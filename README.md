This repository shows how to do species name reconciliation using a DarwinCore Archives,
more specifically artsnabnebase from artsdatabanken, using only DuckDB, in pure SQL.

It supports Norwegian vernacular names as well.

# Requirements

- [duckdb](https://duckdb.org/install/)

# Usage

Run `init.sql` to populate your database. For example:

```bash
duckdb artsnavnebase.duckdb -f init.sql
```

Then run your query on such database.

The `examples.sql` files provides various examples, to match single or multiple species.

Here is the current output when running the examples from the DuckDB command line tool:

```
$ duckdb artsnavnebase.duckdb -f examples.sql
Look for similar scientific names: gulo gulo
┌─────────┬────────────────┬────────┐
│ taxonID │ scientificName │ score  │
│  int64  │    varchar     │ double │
├─────────┼────────────────┼────────┤
│   48072 │ Gulo gulo      │    1.0 │
└─────────┴────────────────┴────────┘
Look for similar Bokmål vernacular names: fjellrev
┌─────────┬──────────────────────────────────────────┬────────────────┬────────────────────┐
│ taxonID │              scientificName              │ vernacularName │       score        │
│  int64  │                 varchar                  │    varchar     │       double       │
├─────────┼──────────────────────────────────────────┼────────────────┼────────────────────┤
│   48032 │ Vulpes lagopus                           │ fjellrev       │                1.0 │
│  101457 │ Cerastium alpinum                        │ fjellarve      │ 0.9527777777777777 │
│   78199 │ Lobaria linita                           │ fjellnever     │ 0.9349999999999999 │
│  105447 │ Marchantia polymorpha subsp. montivagans │ fjelltvare     │ 0.9349999999999999 │
│   69198 │ Cladonia mitis                           │ fjellreinlav   │ 0.9333333333333333 │
└─────────┴──────────────────────────────────────────┴────────────────┴────────────────────┘
Match the closest Bokmål vernacular name extending example_names.csv
┌────────────┬─────────┬────────────────┬────────────────┬────────┐
│    name    │ taxonID │ scientificName │ vernacularName │ score  │
│  varchar   │  int64  │    varchar     │    varchar     │ double │
├────────────┼─────────┼────────────────┼────────────────┼────────┤
│ grevling   │   48078 │ Meles meles    │ grevling       │    1.0 │
│ sau        │   48132 │ Ovis aries     │ sau            │    1.0 │
│ Fjellrever │   48032 │ Vulpes lagopus │ fjellrev       │   0.96 │
│ Aragorn    │    NULL │ NULL           │ NULL           │   NULL │
└────────────┴─────────┴────────────────┴────────────────┴────────┘
```

## Integration

A Python or R user could just run the initialization using a in-memory database (such as `:memory:`)
and execute the queries on the flight.
