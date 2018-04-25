PROMPT *** drop index INTRATN_BR_IDX ***

Begin
execute immediate 'drop index INTRATN_BR_IDX';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/ 
show errors;

