

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DILER_KURS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DILERKURS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS ADD CONSTRAINT FK_DILERKURS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DILERKURS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS ADD CONSTRAINT FK_DILERKURS_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DILER_KURS.sql =========*** End *
PROMPT ===================================================================================== 
