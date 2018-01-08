

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TASK_STAFF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TASK_STAFF_METHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.TASK_STAFF ADD CONSTRAINT FK_TASK_STAFF_METHOD FOREIGN KEY (METHOD)
	  REFERENCES BARS.TASK_METHOD (METHOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TASK_STAFF_TASK_LIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.TASK_STAFF ADD CONSTRAINT FK_TASK_STAFF_TASK_LIST FOREIGN KEY (TASK_ID)
	  REFERENCES BARS.TASK_LIST (TASK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TASK_STAFF.sql =========*** End *
PROMPT ===================================================================================== 
