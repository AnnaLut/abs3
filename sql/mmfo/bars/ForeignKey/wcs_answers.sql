

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_ANSWERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ANSWERS_WSID_WS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_ANSWERS ADD CONSTRAINT FK_ANSWERS_WSID_WS_ID FOREIGN KEY (WS_ID)
	  REFERENCES BARS.WCS_WORKSPACES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ANSWERS_QID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_ANSWERS ADD CONSTRAINT FK_ANSWERS_QID_QUESTS_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ANSWERS_BID_BIDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_ANSWERS ADD CONSTRAINT FK_ANSWERS_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_ANSWERS.sql =========*** End 
PROMPT ===================================================================================== 
