
## Experiences on OGC EDR API technology at KNMI (Netherlands)

### Introduction
In 2022 the KNMI Data Platform (KDP) team set up a OGC [EDR API](https://developer.dataplatform.knmi.nl/edr-api) 
for observation data (AWS, airport and offshore platforms).
The resolution of the observation data is 10 minutes, and new observations are added every 10 minutes.
Historical data is available from 2003.
This EDR API has been running in production since Q4 2022 as an alpha release.

In addition to the observation data, other data collections are available through the KDP EDR,
but they are not the focus of this discussion, as the technology used is less relevant for E-SOH.

### Data storage
The data is stored in PostgreSQL/PostGIS (Amazon Aurora Serverless v1 to be precise) using a wide
table approach. Each row consists of parameter values for a single timestamp for a single station.
The dataset has roughly 1 million time points (6 * 24 * 365 * 20). This gives about 60 million rows
in the data table. The data table contains only the station id, the station locations are stored in a separate table.

### API
The API is implemented in Python using [FastAPI](https://fastapi.tiangolo.com/), [Pydantic](https://docs.pydantic.dev/)
and a [package](https://github.com/KNMI/covjson-pydantic) that provides a Pydantic model for CoverageJSON.
The Python code does a `SELECT` statement on the database, and the output is then translated to the
CoverageJSON Pydantic model. Any filtering (including geo) is done in the database.

### Benchmark
Load testing was performed for the following database backends were tested:

- PostgreSQL production setup as described above (2 capacity units, 8 vCPU for API service)
- PostgreSQL on a laptop: similar to described above, but running locally in a `docker compose` stack 
- [Timescale](https://www.timescale.com/) on a laptop: similar to PostgreSQL on a laptop, but with the data
table replaced by a Timescale Hypertable with chunks of 4 weeks, and all data older than 8 weeks compressed, 
giving significant storage savings (21 GB versus 2.4 GB compressed).

We used [Locust](https://locust.io/) to run the following benchmark:

- Full dataset (20 years of data)
- Each query consists of randomly selecting a station (from 5 options), a variable (from 4 options),
a query length (from 1 hour to 1 month), and a random start time in the 20 year period
- Each locust user does their queries in series
- The load test was done  for 1, 10 or 25 parallel users.

Results:

| DB                      | 	Users | 	Requests per second | 	Mean request time (ms) |
|-------------------------|-------:|---------------------:|------------------------:|
| PostgreSQL (production) |    	 1 |                  	16 |                     	42 |
| PostgreSQL (production) |    	10 |                  103 |                     	77 |
| PostgreSQL (production) |    	25 |                 	154 |                    	130 |
| PostgreSQL (laptop)     |    	 1 |                  	23 |                     	32 |
| PostgreSQL (laptop)     |    	10 |                  	78 |                    	100 |
| PostgreSQL (laptop)     |    	25 |                  	80 |                    	250 |
| Timescale (laptop)      |    	 1 |                  	 8 |                    	110 |
| Timescale (laptop)      |    	10 |                  	27 |                    	320 |
| Timescale (laptop)      |    	25 |                  	28 |                    	750 |


Notes:

- The "laptop" tests were performed on a Macbook with `arm64` processor, but `amd64` containers were used
for PostgrSQL and Timescale. So while the laptop results are comparable, 
they should not be compared directly with production results.
  
On average over all these tests, timescale is a factor 3x slower. 
Looking at the detailed results, timescale is especially slower for small request, 
while for requests that retrieve a month of data, the difference is much smaller. 
This could be caused by timescale always having to decompress a month of data (the chunk size) 
even for the smallest request size.
