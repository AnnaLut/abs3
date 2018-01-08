

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SCHEDULE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_EVENT_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE ADD CONSTRAINT R_EVENT_SCHEDULE FOREIGN KEY (EVENT)
	  REFERENCES BARS.EVENT (EVENT) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FREQ_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEDULE ADD CONSTRAINT R_FREQ_SCHEDULE FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SCHEDULE.sql =========*** End ***
PROMPT ===================================================================================== 
