

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CORPS_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CORPSACC_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC ADD CONSTRAINT FK_CORPSACC_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPSACC_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC ADD CONSTRAINT FK_CORPSACC_BANKS2 FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPSACC_CORPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC ADD CONSTRAINT FK_CORPSACC_CORPS FOREIGN KEY (RNK)
	  REFERENCES BARS.CORPS (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CORPS_ACC.sql =========*** End **
PROMPT ===================================================================================== 
