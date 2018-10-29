CREATE OR REPLACE PACKAGE BODY "SERVICEDESK" as 

	procedure create_schema (p in varchar2) is 
	TYPE refcurtyp IS REF CURSOR; 
	v2_cur refcurtyp; 

	begin 
	    execute immediate 'alter session set "_oracle_script"=true'; 
		usr_password := 'mypassword';
		ts_name := upper(substr('TBS_'||p,0,30)); 
		sql_stmt := 'select ts# from v$tablespace where name = '''||ts_name||''''; 
		OPEN v2_cur FOR sql_stmt; 
		fetch v2_cur into tsnumber; 

		if v2_cur%NOTFOUND then 
			dbms_output.put_line('Tablespace not found.'); 
		else 
			execute immediate 'drop tablespace tbs_'|| p ||' including contents and datafiles'; 
			dbms_output.put_line('Tablespace  TBS_'|| p ||' deleted.'); 
		end if; 

		usrname := upper(p); 
		ts_name := upper(substr('TBS_'||p,0,30)); 

		sql_stmt := 'create tablespace '|| ts_name ||' datafile  '''|| ts_name ||''' size 1M reuse autoextend on next 15M maxsize unlimited'; 
		execute immediate sql_stmt; 
		sql_stmt := 'create user '||p||' identified by '||usr_password||' default tablespace ' ||ts_name|| ' QUOTA UNLIMITED ON ' ||ts_name; 

	OPEN v2_cur FOR 'select user_id from dba_users where username = '''||upper(p)||''''; 
	fetch v2_cur into usrnumber; 

	if v2_cur%NOTFOUND then 
		execute immediate sql_stmt; 
	else 
		execute immediate 'drop user '|| p ||' cascade'; 
		execute immediate sql_stmt; 
	end if; 

	execute immediate 'grant iwfm_role to '||p; 
 
	dbms_output.put_line('Username: ' || p); 
	dbms_output.put_line('User-Password: '||usr_password||''); 
	dbms_output.put_line('Tablespace-Name: '||ts_name); 

	CLOSE v2_cur; 
	UTL_FILE.FCLOSE_ALL; 
	end; 

	procedure drop_schema (p in varchar2) is 
	TYPE refcurtyp IS REF CURSOR; 
	v_cur refcurtyp; 
	v2_cur refcurtyp; 

	begin 

		OPEN v_cur FOR 'select user_id from dba_users where username = '''||upper(p)||''''; 
		fetch v_cur into usrnumber; 
		if v_cur%NOTFOUND then 
			dbms_output.put_line('User not found'); 
		else 
			execute immediate 'alter session set "_oracle_script"=true';
			execute immediate 'drop user '|| p ||' cascade'; 
			dbms_output.put_line('User '|| p ||' dropped.'); 
		end if; 

		ts_name := upper(substr('TBS_'||p,0,30)); 
		sql_stmt := 'select ts# from v$tablespace where name = '''||ts_name||''''; 
		OPEN v2_cur FOR sql_stmt; 
		fetch v2_cur into tsnumber; 

		if v2_cur%NOTFOUND then 
			dbms_output.put_line('Tablespace not found.'); 
		else 
			execute immediate 'drop tablespace tbs_'|| p ||' including contents and datafiles'; 
			dbms_output.put_line('Tablespace  TBS_'|| p ||' deleted.'); 
		end if; 
	end; 
end SERVICEDESK; 
	/
