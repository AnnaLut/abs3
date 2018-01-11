

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMS_LIST_TASKS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ID_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_LIST_TASKS ADD CONSTRAINT FK_ID_GROUP FOREIGN KEY (TASK_ID_GROUP)
	  REFERENCES BARS.TMS_TASK_GROUPS (ID_GROUP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMS_LIST_TASKS.sql =========*** E
PROMPT ===================================================================================== 
