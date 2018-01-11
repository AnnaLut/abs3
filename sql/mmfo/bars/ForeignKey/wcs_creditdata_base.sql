

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_CREDITDATA_BASE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CRDDTBASE_TID_QTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT FK_CRDDTBASE_TID_QTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_QUESTION_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_CREDITDATA_BASE.sql =========
PROMPT ===================================================================================== 
