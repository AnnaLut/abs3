

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIM_REPORT_PARAMS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIMREPPARS_REPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_REPORT_PARAMS ADD CONSTRAINT FK_CIMREPPARS_REPS FOREIGN KEY (REPORT_ID)
	  REFERENCES BARS.CIM_REPORTS_LIST (REPORT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIM_REPORT_PARAMS.sql =========**
PROMPT ===================================================================================== 
