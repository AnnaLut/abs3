

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE_VID2.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINMONQUEVID2_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 ADD CONSTRAINT FK_FINMONQUEVID2_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FINMON_QUE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMONQUEVID2_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 ADD CONSTRAINT FK_FINMONQUEVID2_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE_VID2.sql =========*** 
PROMPT ===================================================================================== 