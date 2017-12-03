begin
  execute immediate 'drop index INDREF_CP_REFW_UPDATE';
exception when others  then 
  if  sqlcode=-01418  then null; else raise; end if;
 end;
/