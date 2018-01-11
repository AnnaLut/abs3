

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_CRVACC_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWCRVACCREQUEST_OWCRVREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_REQUEST ADD CONSTRAINT FK_OWCRVACCREQUEST_OWCRVREQ FOREIGN KEY (REQUEST_ID)
	  REFERENCES BARS.OW_CRV_REQUEST (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWCRVACCREQUEST_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_REQUEST ADD CONSTRAINT FK_OWCRVACCREQUEST_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_CRVACC_REQUEST.sql =========**
PROMPT ===================================================================================== 
