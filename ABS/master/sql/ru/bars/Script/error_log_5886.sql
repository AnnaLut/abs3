BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''SW_OWN'',''ERR$_SW_OWN'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''SW_IMPORT'',''ERR$_SW_IMPORT'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/