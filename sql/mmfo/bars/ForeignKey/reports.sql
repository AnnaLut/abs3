

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REPORTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REPORTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS ADD CONSTRAINT FK_REPORTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPORTS_REPORTSF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS ADD CONSTRAINT FK_REPORTS_REPORTSF FOREIGN KEY (IDF)
	  REFERENCES BARS.REPORTSF (IDF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REPS_FORM_REPFORMS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS ADD CONSTRAINT FK_REPS_FORM_REPFORMS_ID FOREIGN KEY (FORM)
	  REFERENCES BARS.REPORT_FORMS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REPORTS.sql =========*** End *** 
PROMPT ===================================================================================== 
