

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_RUN_TRACKING.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TASK_RUN_TRACK_REF_TASK_RUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_RUN_TRACKING ADD CONSTRAINT FK_TASK_RUN_TRACK_REF_TASK_RUN FOREIGN KEY (TASK_RUN_ID)
	  REFERENCES BARS.TMS_TASK_RUN (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMS_TASK_RUN_TRACKING.sql =======
PROMPT ===================================================================================== 
