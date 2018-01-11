

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_DOCS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCDOCS_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS ADD CONSTRAINT FK_CCDOCS_DOCSCHEME FOREIGN KEY (ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCDOCS_CCDOCSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS ADD CONSTRAINT FK_CCDOCS_CCDOCSTATES FOREIGN KEY (STATE)
	  REFERENCES BARS.CC_DOC_STATES (STATE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCDOCS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS ADD CONSTRAINT FK_CCDOCS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_DOCS.sql =========*** End *** 
PROMPT ===================================================================================== 
