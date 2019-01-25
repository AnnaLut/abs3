PROMPT *** Create  index IDX_CIGDOGGENERAL_CUSTID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CIGDOGGENERAL_CUSTID ON BARS.CIG_DOG_GENERAL (CUST_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ReCreate constraint UK_CIGCUSTOMERS_RNK ***
begin   
 execute immediate '
  alter table CIG_CUSTOMERS drop constraint UK_CIGCUSTOMERS_RNK';
exception when others then
  if  sqlcode=-02443  then null; else raise; end if;
 end;
/
  
begin   
 execute immediate '
  drop index UK_CIGCUSTOMERS_RNK';
exception when others then
  if  sqlcode=-01418  then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_CIGCUSTOMERS_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIGCUSTOMERS_RNK ON BARS.CIG_CUSTOMERS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint UK_CIGCUSTOMERS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUSTOMERS ADD CONSTRAINT UK_CIGCUSTOMERS_RNK UNIQUE (RNK)
  USING INDEX';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
