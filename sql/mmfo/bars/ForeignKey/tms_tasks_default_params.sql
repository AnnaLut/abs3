

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASKS_DEFAULT_PARAMS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TASK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASKS_DEFAULT_PARAMS ADD CONSTRAINT FK_TASK_ID FOREIGN KEY (TASK_ID)
	  REFERENCES BARS.TMS_LIST_TASKS (TASK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASKS_DEFAULT_PARAMS.sql ====
PROMPT ===================================================================================== 
