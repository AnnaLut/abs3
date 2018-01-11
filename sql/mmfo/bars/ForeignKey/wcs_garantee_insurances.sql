

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEE_INSURANCES.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSGRTINS_GRTID_GARANTEE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT FK_WCSGRTINS_GRTID_GARANTEE_ID FOREIGN KEY (GARANTEE_ID)
	  REFERENCES BARS.WCS_GARANTEES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTINS_INSID_WCSINS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT FK_WCSGRTINS_INSID_WCSINS_ID FOREIGN KEY (INSURANCE_ID)
	  REFERENCES BARS.WCS_INSURANCES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTINS_WSQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT FK_WCSGRTINS_WSQID_QUESTS_ID FOREIGN KEY (WS_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEE_INSURANCES.sql =====
PROMPT ===================================================================================== 
