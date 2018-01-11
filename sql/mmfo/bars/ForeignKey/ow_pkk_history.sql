

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_PKK_HISTORY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWPKKHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT FK_OWPKKHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKHISTORY_IICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT FK_OWPKKHISTORY_IICFILES FOREIGN KEY (F_N)
	  REFERENCES BARS.OW_IICFILES (FILE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_PKK_HISTORY.sql =========*** E
PROMPT ===================================================================================== 
