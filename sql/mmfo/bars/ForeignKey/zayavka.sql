

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAYAVKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAYAVKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_PRODUCT_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_PRODUCT_GROUP FOREIGN KEY (PRODUCT_GROUP)
	  REFERENCES BARS.KOD_70_4 (P70) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZAYBACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZAYBACK FOREIGN KEY (IDBACK)
	  REFERENCES BARS.ZAY_BACK (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_BENEFCOUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_BENEFCOUNTRY FOREIGN KEY (BENEFCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAYAVKA_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT XFK_ZAYAVKA_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZAYAIMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZAYAIMS FOREIGN KEY (META)
	  REFERENCES BARS.ZAY_AIMS (AIM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BANKS FOREIGN KEY (MFOP)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TABVAL FOREIGN KEY (KV2)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_BANKS2 FOREIGN KEY (MFO0)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_PRIORITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_PRIORITY FOREIGN KEY (PRIORITY)
	  REFERENCES BARS.ZAY_PRIORITY (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_ZATCLOSETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_ZATCLOSETYPES FOREIGN KEY (CLOSE_TYPE)
	  REFERENCES BARS.ZAY_CLOSE_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYAVKA_TABVAL_CONV ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT FK_ZAYAVKA_TABVAL_CONV FOREIGN KEY (KV_CONV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAYAVKA.sql =========*** End *** 
PROMPT ===================================================================================== 
