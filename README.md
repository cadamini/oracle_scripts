# oracle_scripts

Those script should help to quickly setup oracle RDS instances.

To set them up connect to an Oracle instance and connect via sqlplus

Then run `@package.sql` and `@package_body.sql` to have stored procedures for user / schema and tablespace creation / deletion in place. 

Once done, execute the procedure by running exec servicedesk.create_schema('your_schema_name') to create an empty schema. 

To delete it, run servicedesk.drop_schema('your_schema_name').

Note: 
Use `set serveroutput on` to see details of the script run. 

Next steps. Automate datapump import and export.
