PROMPT *** Create  index IDX_TMS_TASK_RUN_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TMS_TASK_RUN_ID ON BARS.TMS_TASK_RUN (RUN_ID, TASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Drop index I1_DYNFILTER ***
declare
    index_doesnt_exist exception;
    pragma exception_init(index_doesnt_exist, -1418);
begin
    execute immediate 'DROP INDEX BARS.I1_DYNFILTER';
exception
    when index_doesnt_exist then
         null;
end;
/

PROMPT *** Create  index I1_DYNFILTER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DYNFILTER ON BARS.DYN_FILTER (TABID, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_MWAYMATCH_DRN_TR ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_MWAYMATCH_DRN_TR ON BARS.MWAY_MATCH (DRN_TR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Drop index IDX_INS_DEAL_ATTRS_VAL ***
declare
    index_doesnt_exist exception;
    pragma exception_init(index_doesnt_exist, -1418);
begin
    execute immediate 'DROP INDEX BARS.IDX_INS_DEAL_ATTRS_VAL';
exception
    when index_doesnt_exist then
         null;
end;
/
