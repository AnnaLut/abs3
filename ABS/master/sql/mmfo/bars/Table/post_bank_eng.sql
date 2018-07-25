
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POST_BANK_ENG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''POST_BANK_ENG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


begin 
  execute immediate '
  CREATE TABLE BARS.POST_BANK_ENG 
   ( POST_ID number CONSTRAINT CC_POST_BANK_POST_ENG_ID_NN NOT NULL,
     POST_ENG_DESC varchar2  (2000), 
     POST_ENG varchar2 (500)
   ) 
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

grant select, insert, update, delete on POST_BANK_ENG to bars_access_defrole;
grant select, insert, update, delete on POST_BANK_ENG to start1;


COMMENT ON TABLE BARS.POST_BANK_ENG IS 'Довідник посад банку на англійскій мові';

COMMENT ON COLUMN BARS.POST_BANK_ENG.POST_ID IS 'Ідентифікатор посади';
COMMENT ON COLUMN BARS.POST_BANK_ENG.POST_ENG_DESC IS 'Посада';
COMMENT ON COLUMN BARS.POST_BANK_ENG.POST_ENG IS 'Посада на англ.';




