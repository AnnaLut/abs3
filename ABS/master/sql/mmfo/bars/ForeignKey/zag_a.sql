

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAG_A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAGA_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A ADD CONSTRAINT FK_ZAGA_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAGA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A ADD CONSTRAINT FK_ZAGA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAG_A.sql =========*** End *** ==
PROMPT ===================================================================================== 
