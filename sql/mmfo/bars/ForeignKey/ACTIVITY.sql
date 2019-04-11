PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/Bars/ForeignKey/ACTIVITY.sql ========= *** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create constraint FK_ACTIVITY_REF_PROC_TYPE ***

begin   
   execute immediate '
   ALTER TABLE BARS.ACTIVITY ADD CONSTRAINT FK_ACTIVITY_REF_PROC_WF FOREIGN KEY (ACTIVITY_TYPE_ID)
	REFERENCES BARS.PROCESS_WORKFLOW (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create constraint FK_ACTIVITY_REF_OBJECT ***

begin   
   execute immediate '
   ALTER TABLE BARS.ACTIVITY ADD CONSTRAINT FK_ACTIVITY_REF_OBJECT FOREIGN KEY (OBJECT_ID)
	REFERENCES BARS.OBJECT (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create constraint FK_ACTIVITY_REF_PROCESS ***

begin   
   execute immediate '
   ALTER TABLE BARS.ACTIVITY ADD CONSTRAINT FK_ACTIVITY_REF_PROCESS FOREIGN KEY (PROCESS_ID)
	REFERENCES BARS.PROCESS (ID) ENABLE NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/Bars/ForeignKey/ACTIVITY.sql ========== *** End *** 
PROMPT ===================================================================================== 
