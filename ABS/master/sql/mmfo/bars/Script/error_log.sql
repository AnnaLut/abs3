BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''NBU_CREDIT_INSURANCE'',''ERR$_NBU_CREDIT_INSURANCE'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

