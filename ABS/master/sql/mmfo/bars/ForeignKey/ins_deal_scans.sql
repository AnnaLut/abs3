

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_SCANS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSDLSSCNS_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS ADD CONSTRAINT FK_INSDLSSCNS_INSDEALS FOREIGN KEY (DEAL_ID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDLSSCNS_DEALTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS ADD CONSTRAINT FK_INSDLSSCNS_DEALTAGS FOREIGN KEY (SCAN_ID, KF)
	  REFERENCES BARS.INS_SCANS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_SCANS.sql =========*** E
PROMPT ===================================================================================== 
