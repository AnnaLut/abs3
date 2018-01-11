

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL$LOCAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TABVAL$LOCAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL ADD CONSTRAINT FK_TABVAL$LOCAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVAL$LOCAL_TABVAL$GLOBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL ADD CONSTRAINT FK_TABVAL$LOCAL_TABVAL$GLOBAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL$LOCAL.sql =========*** End
PROMPT ===================================================================================== 
