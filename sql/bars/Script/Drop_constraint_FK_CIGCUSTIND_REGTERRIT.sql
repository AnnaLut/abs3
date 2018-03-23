  
PROMPT *** Drop  constraint FK_CIGCUSTIND_REGTERRIT ***
begin   
 execute immediate 'alter table BARS.CIG_CUST_INDIVIDUAL drop constraint FK_CIGCUSTIND_REGTERRIT';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-2443 then null; else raise; end if;
 end;
/
