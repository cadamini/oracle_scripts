SET SERVEROUTPUT ON;

DECLARE
  ind NUMBER;              -- Loop index
  h1 NUMBER;               -- Data Pump job handle
BEGIN

-- Create a (user-named) Data Pump job
h1 := DBMS_DATAPUMP.OPEN( operation => 'IMPORT', job_mode => 'SCHEMA', job_name=>'');

-- Specify dump files
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump001.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump101.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump201.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump301.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump401.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump501.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump601.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump701.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump801.dmp','DATA_PUMP_DIR');
DBMS_DATAPUMP.ADD_FILE(h1,'exp_my_dump901.dmp','DATA_PUMP_DIR');

-- Specify the schema that will be exported
-- Remap schemas and tablespace
DBMS_DATAPUMP.METADATA_FILTER(h1,'SCHEMA_EXPR','IN (''myschematoexport'')');
DBMS_DATAPUMP.METADATA_REMAP(h1,'REMAP_SCHEMA','sourceschema','targetschema'); 
DBMS_DATAPUMP.METADATA_REMAP(h1,'REMAP_TABLESPACE','sourcetablespace','targettablespace'); 


DBMS_DATAPUMP.START_JOB(h1);
dbms_output.put_line('Job has completed');
dbms_output.put_line('Final job state = ' || job_state);
dbms_datapump.detach(h1);
END;
/

-- TODO:
-- Write to log and report import status, not found any option to display a log with errors, 
-- using console for now
-- status updates as in the manual are not working, can be added later

