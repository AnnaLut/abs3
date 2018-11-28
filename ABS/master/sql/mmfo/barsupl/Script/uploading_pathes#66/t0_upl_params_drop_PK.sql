
PROMPT *** DROP constraint PK_T0UPLOADPARAMS ***
begin
 execute immediate 'ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS DROP PRIMARY KEY';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-2441 then null; else raise; end if;
 end;
/

PROMPT *** DROP index PK_T0UPLOADPARAMS ***
begin
 execute immediate 'drop index BARSUPL.PK_T0UPLOADPARAMS';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-1418 then null; else raise; end if;
 end;
/

