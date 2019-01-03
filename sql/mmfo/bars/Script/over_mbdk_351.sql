PROMPT *** drop procedure over_351 ***
begin   
 execute immediate 'drop procedure over_351';
exception when others then
  if  sqlcode=-4043 then null; else raise; end if;
 end;
/

PROMPT *** drop procedure mbdk_351 ***
begin   
 execute immediate 'drop procedure mbdk_351';
exception when others then
  if  sqlcode=-4043 then null; else raise; end if;
 end;
/
