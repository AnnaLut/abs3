BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_REGIONS'',''ERR$_ADR_REGIONS'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_AREAS'',''ERR$_ADR_AREAS'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_SETTLEMENT_TYPES'',''ERR$_ADR_SETTLEMENT_TYPES'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_SETTLEMENTS'',''ERR$_ADR_SETTLEMENTS'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_CITY_DISTRICTS'',''ERR$_ADR_CITY_DISTRICTS'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_STREET_TYPES'',''ERR$_ADR_STREET_TYPES'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_STREETS'',''ERR$_ADR_STREETS'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_HOUSES'',''ERR$_ADR_HOUSES'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
BEGIN 
        execute immediate  
          'begin  
              dbms_errlog.create_error_log (''ADR_PHONE_CODES'',''ERR$_ADR_PHONE_CODES'');
           end; 
          '; 
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

 
