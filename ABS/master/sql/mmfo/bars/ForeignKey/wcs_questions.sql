

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_QUESTIONS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_QUESTS_TID_QUESTTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTIONS ADD CONSTRAINT FK_QUESTS_TID_QUESTTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_QUESTION_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_QUESTIONS.sql =========*** En
PROMPT ===================================================================================== 
