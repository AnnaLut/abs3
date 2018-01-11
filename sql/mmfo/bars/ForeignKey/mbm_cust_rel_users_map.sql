

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBM_CUST_REL_USERS_MAP.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C00111427 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_CUST_REL_USERS_MAP ADD FOREIGN KEY (CUST_ID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBM_CUST_REL_USERS_MAP.sql ======
PROMPT ===================================================================================== 
