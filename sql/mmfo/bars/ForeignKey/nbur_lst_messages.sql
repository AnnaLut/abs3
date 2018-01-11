

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_MESSAGES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBURLSTMESES_LSTFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_MESSAGES ADD CONSTRAINT FK_NBURLSTMESES_LSTFILES FOREIGN KEY (REPORT_DATE, KF, VERSION_ID)
	  REFERENCES BARS.NBUR_LST_VERSIONS (REPORT_DATE, KF, VERSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_LST_MESSAGES.sql =========**
PROMPT ===================================================================================== 
