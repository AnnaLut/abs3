begin 
  execute immediate 'ALTER TABLE BARS.ERRORS_351 DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin
    execute immediate 'DROP INDEX BARS.PK_ERRORS_351';
exception when others then 
  if sqlcode in (-1418) then null; else raise; end if;
end;
/


begin
  EXECUTE IMMEDIATE 
  'ALTER TABLE ERRORS_351 ADD CONSTRAINT PK_ERRORS_351 PRIMARY KEY (FDAT,ND,RNK,TIP) 
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI';

exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/