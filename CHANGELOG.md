0.0.8
======

* Show the used keyspace at startup
* Check, whether the constellation thread is alive or not before killing it

0.0.7
=====

* Show exception's messages inside of a system log entry
* Added compatibility to Titan 0.2.0

0.0.6
======

* The constellation runner starts now as a daemon using the Titan gem. It can be started via 'constellation stop' and stopped by using 'constellation stop'.

0.0.5
======

* Added support for querying log entries that have both a defined application and machine

0.0.4
======

* Added --debug (or -d) option for the cli that can be used by "constellation start --debug" in order to put read log entries or raised exceptions

0.0.3
======

* Added sorting column families in order to provide retrieving log entries alphabetically ordered by their machine or application

0.0.2
======

* Introducing Constellation::UserInterface in order to provide formatted console output
* Improved Cassandra data model

0.0.1
======

* Initial release including:
  * Constellation::Config
  * Constellation::DataStore
  * Constellation::LogEntry
  * Constellation::Reader
  * Constellation::Runner
