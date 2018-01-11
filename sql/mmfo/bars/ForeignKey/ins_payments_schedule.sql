

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PAYMENTS_SCHEDULE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSPSCH_DEALID_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PAYMENTS_SCHEDULE ADD CONSTRAINT FK_INSPSCH_DEALID_DEALS FOREIGN KEY (DEAL_ID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PAYMENTS_SCHEDULE.sql =======
PROMPT ===================================================================================== 
