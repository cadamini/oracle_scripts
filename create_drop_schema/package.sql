CREATE OR REPLACE PACKAGE "SYS"."RDS"

AUTHID CURRENT_USER
IS
    tsnumber number; 
    usrnumber number; 
	usrname varchar2(40); 
	usr_password varchar2(20); 
	ts_name varchar2(30);
	sql_stmt varchar2(255); 
	
procedure create_schema(p in varchar2);
procedure drop_schema(p in varchar2); 
end rds; 
/
