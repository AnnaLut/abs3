

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILEROW_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT FK_DPTFILEROW_OPER FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROW_DPTFILEHEADER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT FK_DPTFILEROW_DPTFILEHEADER FOREIGN KEY (HEADER_ID)
	  REFERENCES BARS.DPT_FILE_HEADER (HEADER_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROW_AGENCYID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT FK_DPTFILEROW_AGENCYID FOREIGN KEY (AGENCY_ID)
	  REFERENCES BARS.SOCIAL_AGENCY (AGENCY_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROW_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT FK_DPTFILEROW_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEROW_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT FK_DPTFILEROW_TIPS FOREIGN KEY (ACC_TYPE)
	  REFERENCES BARS.TIPS (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW.sql =========*** End
PROMPT ===================================================================================== 
