PROMPT *** Filling table ZDK ***

truncate table zdk;

begin 
  execute immediate 'insert into ZDK select 1 dk, ''Купівля'' z_type from dual
    	                             union all
		   	             select 2 dk,''Продаж'' z_type from dual
				     union all
				     select 3 dk, ''Конверсія купівля'' z_type from dual
				     union all
  				     select 4 dk, ''Конверсія продаж'' z_type from dual';
exception when others then null; 
end; 
/
COMMIT;
