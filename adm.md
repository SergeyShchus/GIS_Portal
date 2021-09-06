ArcGIS Data Store


1. ArcGIS Data Store REST commands


When you configure ArcGIS Data Store, you associate it with the GIS Server site that will serve as your portal's hosting server. Actions that change or check the status of the data store, or remove the data store from the GIS Server site, are performed from the ArcGIS Server Administrator Directory. (The URL format is https://gisserver.domain.com:6443/arcgis/admin.) The following sections summarize these operations and link to the ArcGIS API documentation.

The functions described below

Relational data store: data > items > enterpriseDatabases > <data store name> > machines > <machine name> > validate
Spatiotemporal big data store: data > items > nosqlDatabases > AGSDataStore_bigdata_<data store name> > machines > <machine name>
Tile cache data store: data > items > nosqlDatabases > AGSDataStore_nosql_<data store name> > machines > <machine name>
  
  
  
 Change the status of a data store machine
You can stop and restart individual machines in a data store. You can also promote a standby relational and tile cache data store machine to be the primary.

Stopping the primary relational or tile cache data store machine does not cause the data store to failover in an on-premises deployment, as you may not want to failover if you are performing a maintenance task, such as temporarily taking the data store offline.

For example, you change data store machine status as part of the following upgrade scenario:

Stop the standby machine.
Upgrade the standby.
Start the standby.
Promote the standby to primary using the makePrimary command.
Stop the former primary machine.
Upgrade the former primary.
Start the former primary.
Add the former primary machine back to the data store as the standby machine.
Log in to the ArcGIS Server Administrator Directory as the ArcGIS Server site administrator and go to a specific machine to use any of the following commands to change the status of a data store machine:

stop
start
makePrimary (standby relational and tile cache data store machines only)
Validate the data store
You can check the status of the machines in a data store using the validate ArcGIS Server REST command.

Log in to the ArcGIS Server Administrator Directory as the ArcGIS Server site administrator and click validate to see the health (healthy or unhealthy), status (started or stopped), and role (primary or standby - relational and tile cache data stores only) of each machine in the data store.

You might validate the data store to confirm a machine has been stopped or started, to confirm the standby was made primary after you used the makePrimary command, or as an initial troubleshooting step if hosted feature or scene layers cannot be published or accessed.

Remove a standby machine
You can remove a standby machine from a relational or tile cache data store using the remove ArcGIS Server REST command. For example, if you want to use a different computer for the standby, you could remove the old standby machine from the data store, install ArcGIS Data Store on the new machine, and configure the new machine as the standby.

Log in to the ArcGIS Server Administrator Directory as the ArcGIS Server site administrator to use the remove command.
  
  
2. Перевірка працездатності ArcGis Data Store
  https://gisserver.domain.com:6443/arcgis/admin
  
  Home > data > items > enterpriseDatabases > AGSDataStore_ds_datastoreID > edit
Copy the JSON from the Item field.
Navigate to the following path:
Home > data > validateDataItem
Paste the JSON in the Item field.
Select JSON from the Format drop-down menu. Click Validate. Successfully validating the data store loads a new page displaying {"status": "success"}.
  

  
  
  3. Restart ArcGis Data Store
  
  To attempt to restart the Data Store Machine, go to the Server Admin Data Store Machine Properties page (URL looks something like this: https://gisserver.domain.com/server/admin/data/items/enterpriseDatabases/AGSDataStore_ds_wztxj7um/machines/GISSERVER.DOMAIN.COM)

ArcGIS Server Administrator Directory - Data Store Machine Properties

Click start, change the format to JSON, and click Start.

ArcGIS Server Administrator Directory - Start Datastore Machine

It may take a few minutes for the Data Store Machine to start up. When it is done you should see a message that says {"status": "success"}. When you do, return to the ArcGIS Server Manager data store page and validate the data store again. It should now have a green check mark next to it. If not, you may need to reach out to Esri Technical Support for further troubleshooting.

  
  
  
  4. ArcGIS Data Store command utility reference
  https://enterprise.arcgis.com/en/portal/latest/administer/windows/data-store-utility-reference.htm
  
