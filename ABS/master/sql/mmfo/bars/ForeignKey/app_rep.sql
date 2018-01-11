

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/APP_REP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_APPREP_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT FK_APPREP_STAFF FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_APPREP_APPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT FK_APPREP_APPLIST FOREIGN KEY (CODEAPP)
	  REFERENCES BARS.APPLIST (CODEAPP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_APPREP_REPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT FK_APPREP_REPORTS FOREIGN KEY (CODEREP)
	  REFERENCES BARS.REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/APP_REP.sql =========*** End *** 
PROMPT ===================================================================================== 
