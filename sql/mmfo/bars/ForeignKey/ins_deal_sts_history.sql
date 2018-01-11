

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_STS_HISTORY.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSDLSSTSHIST_STSID_INSDSTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY ADD CONSTRAINT FK_INSDLSSTSHIST_STSID_INSDSTS FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.INS_DEAL_STATUSES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDLSSTSHIST_STFID_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY ADD CONSTRAINT FK_INSDLSSTSHIST_STFID_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDLSSTSHIST_DID_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STS_HISTORY ADD CONSTRAINT FK_INSDLSSTSHIST_DID_INSDEALS FOREIGN KEY (DEAL_ID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_STS_HISTORY.sql ========
PROMPT ===================================================================================== 
