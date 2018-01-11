

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLP_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FILES ADD CONSTRAINT FK_KLPFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLP_FILES.sql =========*** End **
PROMPT ===================================================================================== 
