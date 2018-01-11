

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUST_ZAY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTZAY_BANKS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT FK_CUSTZAY_BANKS1 FOREIGN KEY (MFOP)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTZAY_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT FK_CUSTZAY_BANKS2 FOREIGN KEY (MFO26)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTZAY_BANKS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT FK_CUSTZAY_BANKS3 FOREIGN KEY (MFOV)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUST_ZAY_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT FK_CUST_ZAY_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTZAY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT FK_CUSTZAY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUST_ZAY.sql =========*** End ***
PROMPT ===================================================================================== 
