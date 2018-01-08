

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWFILES_OWFILETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT FK_OWFILES_OWFILETYPE FOREIGN KEY (FILE_TYPE)
	  REFERENCES BARS.OW_FILE_TYPE (FILE_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT FK_OWFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
