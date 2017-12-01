begin
  execute immediate 'drop index XAI_CP_REFW_UPDATEPK';
exception when others  then 
  if  sqlcode=-01418  then null; else raise; end if;
 end;
/