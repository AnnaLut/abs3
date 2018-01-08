

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_STOPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STOPS_TID_STOPTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS ADD CONSTRAINT FK_STOPS_TID_STOPTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_STOP_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPS_RQID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STOPS ADD CONSTRAINT FK_STOPS_RQID_QUEST_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_STOPS.sql =========*** End **
PROMPT ===================================================================================== 
