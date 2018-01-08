

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_COMISS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAY_COMISS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT FK_ZAY_COMISS_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_ZAY_COMISS_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT XFK_ZAY_COMISS_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYCOMISS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT FK_ZAYCOMISS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_COMISS.sql =========*** End *
PROMPT ===================================================================================== 
