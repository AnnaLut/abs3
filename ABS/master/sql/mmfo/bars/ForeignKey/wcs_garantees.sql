

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSGRTS_RQID_STSQID_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT FK_WCSGRTS_RQID_STSQID_ID FOREIGN KEY (STATUS_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTS_SID_SCOPIES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT FK_WCSGRTS_SID_SCOPIES_ID FOREIGN KEY (SCOPY_ID)
	  REFERENCES BARS.WCS_SCANCOPIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTS_SURID_SURVEYS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT FK_WCSGRTS_SURID_SURVEYS_ID FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.WCS_SURVEYS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTS_RQID_CNTQID_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT FK_WCSGRTS_RQID_CNTQID_ID FOREIGN KEY (COUNT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTS_WSID_WS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT FK_WCSGRTS_WSID_WS_ID FOREIGN KEY (WS_ID)
	  REFERENCES BARS.WCS_WORKSPACES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEES.sql =========*** En
PROMPT ===================================================================================== 
