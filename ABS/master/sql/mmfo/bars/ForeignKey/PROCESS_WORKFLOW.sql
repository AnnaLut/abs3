PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/Bars/ForeignKey/PROCESS_WORKFLOW.sql ===== *** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create constraint FK_PROC_FLOW_REF_PROC_TYPE ***

begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_WORKFLOW ADD CONSTRAINT FK_PROC_FLOW_REF_PROC_TYPE FOREIGN KEY (PROCESS_TYPE_ID)
	REFERENCES BARS.PROCESS_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/Bars/ForeignKey/PROCESS_WORKFLOW.sql ===== *** End ***
PROMPT ===================================================================================== 
