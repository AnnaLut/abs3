

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_SALARY_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWSALARYFILES_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES ADD CONSTRAINT FK_OWSALARYFILES_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWSALARYFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_FILES ADD CONSTRAINT FK_OWSALARYFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_SALARY_FILES.sql =========*** 
PROMPT ===================================================================================== 
