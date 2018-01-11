

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_PKK_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWPKKQUE_OWIICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_OWIICFILES FOREIGN KEY (F_N)
	  REFERENCES BARS.OW_IICFILES (FILE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKQUE_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_PKK_QUE.sql =========*** End *
PROMPT ===================================================================================== 
