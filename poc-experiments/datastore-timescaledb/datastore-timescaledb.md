## TimescaleDB research/experiments
TimescaleDB is an open-source database designed to make SQL scalable for time-series data.  
It extends PostgreSQL with features such as native time-series partitioning, compression, and continuous aggregates to improve the performance and scalability of time-series data management.
Hypertables are PostgreSQL tables with special features that improve performance and user experience for time-series data. Hypertables are divided in chunks that hold data only from a specific time range. When a query for a particular time range is executed, the planner can ignore chunks that have data outside of that time range
TimescaleDB’s native compression works by converting uncompressed rows of data into compressed columns. When new data is added to database, it is in the form of uncompressed rows. TimescaleDB uses a built-in job scheduler to convert this data to the form of compressed columns.
Compression can be enabled on individual hypertables by declaring which columns to segment by. Once compression is enabled, the data can then be compressed in by using an automatic policy or manually compressing chunks.
By reducing the amount of data that needs to be read, compression can lead to increases in performance. However benefits of compression depends on data and queries that are run against it.
One useful TimescleDB feature is continuous aggregates which can be used to pre-aggregate data into useful summaries. Materialized views are used continuously and incrementally refresh a query in the background.
