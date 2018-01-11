

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTCOUNT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C0014362 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTCOUNT ADD FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TIPCOUNT_CUSTCOU ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTCOUNT ADD CONSTRAINT R_TIPCOUNT_CUSTCOU FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPCOUNT (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTCOUNT.sql =========*** End **
PROMPT ===================================================================================== 
