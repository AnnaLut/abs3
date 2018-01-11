

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_RUN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TMS_TASK_RUN_REF_RUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN ADD CONSTRAINT FK_TMS_TASK_RUN_REF_RUN FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.TMS_RUN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMS_TASK_RUN_REF_TASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN ADD CONSTRAINT FK_TMS_TASK_RUN_REF_TASK FOREIGN KEY (TASK_ID)
	  REFERENCES BARS.TMS_TASK (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_RUN.sql =========*** End
PROMPT ===================================================================================== 
