

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INSURANCES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSINS_SURID_SURVEYS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES ADD CONSTRAINT FK_WCSINS_SURID_SURVEYS_ID FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.WCS_SURVEYS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSINS_RQID_CNTQID_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES ADD CONSTRAINT FK_WCSINS_RQID_CNTQID_ID FOREIGN KEY (COUNT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSINS_RQID_STSQID_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES ADD CONSTRAINT FK_WCSINS_RQID_STSQID_ID FOREIGN KEY (STATUS_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INSURANCES.sql =========*** E
PROMPT ===================================================================================== 
