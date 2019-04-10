PROMPT ===================================================================================== 
PROMPT *** Run ***  Scripts /Sql/Bars/ForeignKey/PROCESS_WORKFLOW_DEPENDENCY.sql *** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create constraint FK_PROC_FLOW_DEP_REF_PRIME ***

begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW_DEPENDENCY ADD CONSTRAINT FK_PROC_FLOW_DEP_REF_PRIME FOREIGN KEY (PRIMARY_ACTIVITY_ID)
	REFERENCES BARS.PROCESS_WORKFLOW (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create constraint FK_PROC_FLOW_DEP_REF_FOLLOW ***

begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW_DEPENDENCY ADD CONSTRAINT FK_PROC_FLOW_DEP_REF_FOLLOW FOREIGN KEY (FOLLOWING_ACTIVITY_ID)
	REFERENCES BARS.PROCESS_WORKFLOW (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End ***  Scripts /Sql/Bars/ForeignKey/PROCESS_WORKFLOW_DEPENDENCY.sql *** End *** 
PROMPT ===================================================================================== 
