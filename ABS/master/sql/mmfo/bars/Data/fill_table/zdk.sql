PROMPT *** Filling table ZDK ***

truncate table zdk;

begin 
  execute immediate 'insert into ZDK select 1 dk, ''������'' z_type from dual
    	                             union all
		   	             select 2 dk,''������'' z_type from dual
				     union all
				     select 3 dk, ''�������� ������'' z_type from dual
				     union all
  				     select 4 dk, ''�������� ������'' z_type from dual';
exception when others then null; 
end; 
/
COMMIT;
