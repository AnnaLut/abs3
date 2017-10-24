prompt ------------------------------------------
prompt  создание последовательности S_OW_CNG_TYPES 
prompt ------------------------------------------
/
begin 
 execute immediate 'CREATE SEQUENCE s_ow_cng_types
                      START WITH 1
                      MAXVALUE 999999999999999999999999999
                      MINVALUE 1
                      NOCYCLE
                      CACHE 20
                      NOORDER';
exception when others then if (sqlcode = -00955) then null; else raise; end if;
end;                      
/
GRANT SELECT ON S_OW_CNG_TYPES TO BARS_ACCESS_DEFROLE;
/

