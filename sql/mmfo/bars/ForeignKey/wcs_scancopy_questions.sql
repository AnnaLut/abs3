

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SCOPYQUESTS_SID_SCOPIES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT FK_SCOPYQUESTS_SID_SCOPIES_ID FOREIGN KEY (SCOPY_ID)
	  REFERENCES BARS.WCS_SCANCOPIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCOPYQUESTS_QID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT FK_SCOPYQUESTS_QID_QUEST_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCOPYQUESTS_TID_SCTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT FK_SCOPYQUESTS_TID_SCTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_SCANCOPY_QUESTION_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 
