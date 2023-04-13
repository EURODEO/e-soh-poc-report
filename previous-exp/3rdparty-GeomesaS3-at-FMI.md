
## Experiences on using Geomesa and S3 storage for 3rdparty observations (FMI, Finland)

Development of a new 3rdparty handling system based on S3 file storage started from motivation to cut down the operation costs of the PostGIS based solution (see the previous section). Development project's target was to find a solution that doesn't have that steep price curve when the amount of data is scaled up by factor of 10 or 100 or even 1000.

Development of the system took place in 2021 in a project supported by external consultants who did the majority of the technical planning, evaluation and implementation. Scope of the implementation was data ingestion from 3rdparty data provider (fetch data from there) into data storage, then running TITAN QC for that data and serving it out through OGC EDR API, which was integral part of the reference/PoC impelementation.

The project resulted in MIT-licensed "proof-of-concept" stage system called TIUHA -- code shared on Github, see url: https://github.com/fmidev/tiuha. After the development phase FMI has worked on the QC part and transferred the system to run on Openshift environment (fork to be merged).

Here we represent the fundamental concept of the system and list some pros and cons.

