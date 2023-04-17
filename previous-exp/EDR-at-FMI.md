## Experiences on OGC EDR API technology at FMI (Finland)

### Introduction

OGC API EDR at FMI was first implemented in the [GeoE3 project](https://geoe3.eu/) as a plugin to FMI's existing [SmartMet Server data server](https://github.com/fmidev/smartmet-server). There it has already been utilized for a number of use cases including Intelligent Traffic and Energy Efficiency for buildings.

In addition to GeoE3 project the main drivers to use EDR is the Geoweb weather visualization project developed in collaboration with Met Norway and KNMI and provide a more user friendly open data interface replacing the legacy OGC WFS. Geoweb will act as an EDR client to visualize timeseries data for users. OGC WFS provides complex XML based output whereas OGC API EDR by default recommends CoverageJSON which is more suitable for web development purposes. It also converts more nicely to HTML via the OpenAPI specification which enables data to be indexed by search engines more easily.

As a side note, OGC API Features was first considered as a replacement for the legacy OGC WFS but EDR has better support for spatio-temporal data so focus was switched to EDR instead. Most probably OGC API Features will also be implemented at some stage as it has currently better client support.

### Supported query types

FMI implementation currently supports the following EDR query types

- Position
- Area
- Trajectory
- Radius
- Location
- Instance

Of these, __Location__ and __Trajectory__ query are already used and proven efficient in the GeoE3 project. The __Trajectory__ query is used to get temperatures along a road and the __Location__ query for outside temperature for a location (related to building heating).

### Implementation experiences and issues

The OGC API EDR specification really only specifies how the API should look like. Internal implementation details are in the scope of the implementer. FMI built EDR on top of it's existing data server which meant we could utilize existing data engines and data structures. Thus it only took a limited amount of time to provide a new interface on top of that.

- difficulties with aviation/IWXXM stuff
- data model
- compatibility between EDR servers

### Publish-Subscribe support

The upcoming WMO WIS2, EUMETNET FEMDI and SWIM (ICAO's aviation framework) will all require some kind of PubSub support mechanism. The upcoming version (1.2) of EDR is adding support for AsyncAPI. With that it will be nicely aligned to support the different requirements from the mentioned undertakings.

The challenges are that SWIM and WIS2/FEMDI require a different PubSub protocol, SWIM AMQP 1.0 and WIS2/FEMDI MQTT. This means there has to be a bridge built between them or have separate implementations for the two use cases.