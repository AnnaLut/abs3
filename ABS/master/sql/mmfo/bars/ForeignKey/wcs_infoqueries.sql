

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INFOQUERIES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INFOQUERIES_RMQID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT FK_INFOQUERIES_RMQID_QUEST_ID FOREIGN KEY (RESULT_MSG_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INFOQUERIES_ÅID_IQTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT FK_INFOQUERIES_ÅID_IQTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_INFOQUERY_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INFOQUERIES_RQID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT FK_INFOQUERIES_RQID_QUEST_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INFOQUERIES.sql =========*** 
PROMPT ===================================================================================== 
