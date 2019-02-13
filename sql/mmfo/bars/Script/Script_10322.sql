begin   
 execute immediate 'drop index IDX_FINDEBARC_EFFECTDT_ACCSS';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/
