## Experiences on PostGIS-based database for 3rdparty observations

FMI has been using PostgreSQL and PostGIS as a database solution for many years. For 3rdparty observations, FMI has been using during recent years PostGIS in AWS (RDS, Relational Database Service, i.e. relational database as a service). The database schema is planned to be flexible enough to contain different kind of datasets and adding new dataset is planned to be easy. Here we explain the concept with a simplified diagram.


![](previous-exp/3rdparty-postgis-FMI-simplified.drawio.png) 

The database is based on narrow data table paradigm, and the data table is shown in the figure as "3rdparty_obsdata" (Not all fields are shown, but just the essential ones to explain the concept. There are e.g. quality control related fields in the table that are not shown here).

Every measured parameter per timestamp (and per station) is inserted as a new row in the database. There are flexibility to ingest either numerical values or textual values (or even both) depending on each parameter's need. But before ingesting data, there should be defined a producer for that dataset. Producer has its own parameter namespace and station namespace. Aim is that the data producer can ingest its own station identifiers and the database can handle own station id namespace for each data producer. Data ingestion logic (written in pg/SQL) handles creation of new stations and parameters automatically based on the data input.

Producers can be separated in data server API, i.e. some api-key (user) may have access to certain provider(s) and another api-key to some others. This come in handy e.g. when there are different kind of data licenses for the datasets.

This database (integrated with) and used via Smartmet Server API, typically using OGC WFS or Smartmet Server proprietary "timeseries plugin" queries. Integration could benefit from the PostGIS database's ability to execute spatial queries, we didn't need to implement that ourselves on the data server side.

### Pros and cons

Pros: 

1. flexibility to ingest different kinds of datasets with their own station codes and measurement parameters
2. no need to manually add parameters and/or stations (once producer is created)
3. relational database is easy expand with growing metadata needs
4. well-thought partitioning have kept queries efficient enough
5. PostGIS provides us the ability to execute geospatial data queries easily

Cons:

1. it may not directly scale to big amounts of data (lots of rows)
2. it's relatively expensive to store (and operate) big amount of data in AWS RDS database.
3. every producer has its own measurand namespace, there is the question how to have unified parameter catalogue. Unresolved.
