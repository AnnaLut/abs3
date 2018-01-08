

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CORPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CORPS_BANKS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT FK_CORPS_BANKS3 FOREIGN KEY (MAINMFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPS_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT FK_CORPS_BANKS2 FOREIGN KEY (MFONEW)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT FK_CORPS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPS_CUSTBINDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT FK_CORPS_CUSTBINDATA FOREIGN KEY (SEAL_ID)
	  REFERENCES BARS.CUSTOMER_BIN_DATA (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CORPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
