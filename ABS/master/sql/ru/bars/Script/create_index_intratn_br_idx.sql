PROMPT *** Create  index INTRATN_BR_IDX ***

Begin
execute immediate 'create index INTRATN_BR_IDX on BARS.INT_RATN (BR)
  tablespace BRSBIGI
  pctfree 10
  initrans 2
  maxtrans 255
  compute statistics';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/ 

