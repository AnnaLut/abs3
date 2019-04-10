PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/Bars/ForeignKey/PROCESS_HISTORY.sql ===== *** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create constraint FK_PROCESS_REFERENCE_PROCESS ***

begin   
   execute immediate '
   ALTER TABLE PROCESS_HISTORY ADD CONSTRAINT FK_PROCESS_REFERENCE_PROCESS FOREIGN KEY (PROCESS_ID)
   REFERENCES PROCESS (ID) on delete cascade NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/Bars/ForeignKey/PROCESS_HISTORY.sql ===== *** End ***
PROMPT ===================================================================================== 
