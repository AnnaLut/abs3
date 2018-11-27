BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''NBUR_OVDP_6EX'',''ERR$_NBUR_OVDP_6EX'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/