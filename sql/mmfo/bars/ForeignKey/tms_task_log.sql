

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TASKLOG_IDTASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_LOG ADD CONSTRAINT FK_TASKLOG_IDTASK FOREIGN KEY (ID_TASK)
	  REFERENCES BARS.TMS_LIST_TASKS (TASK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TASKLOG_IDGROUPLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_LOG ADD CONSTRAINT FK_TASKLOG_IDGROUPLOG FOREIGN KEY (ID_GROUP_LOG)
	  REFERENCES BARS.TMS_GROUP_LOG (ID_GROUP_LOG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_LOG.sql =========*** End
PROMPT ===================================================================================== 
