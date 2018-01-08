

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEE_TEMPLATES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTTMPLS_TID_TMPLS_TID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_TEMPLATES ADD CONSTRAINT FK_GRTTMPLS_TID_TMPLS_TID FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.WCS_TEMPLATES (TEMPLATE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTTMPLS_PSID_PRNSTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_TEMPLATES ADD CONSTRAINT FK_GRTTMPLS_PSID_PRNSTS_ID FOREIGN KEY (PRINT_STATE_ID)
	  REFERENCES BARS.WCS_PRINT_STATES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTTMPLS_SQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_TEMPLATES ADD CONSTRAINT FK_GRTTMPLS_SQID_QUESTS_ID FOREIGN KEY (SCAN_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_GARANTEE_TEMPLATES.sql ======
PROMPT ===================================================================================== 
