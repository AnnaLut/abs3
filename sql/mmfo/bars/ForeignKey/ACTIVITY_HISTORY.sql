PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/Bars/ForeignKey/ACTIVITY_HISTORY.sql ===== *** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create constraint FK_ACTIVITY_REFERENCE_ACTIVITY ***

begin   
   execute immediate '
   ALTER TABLE ACTIVITY_HISTORY ADD CONSTRAINT FK_ACTIVITY_HIST_REF_ACTIVITY FOREIGN KEY (ACTIVITY_ID)
   REFERENCES ACTIVITY (ID) on delete cascade NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/Bars/ForeignKey/ACTIVITY_HISTORY.sql ===== *** End ***
PROMPT ===================================================================================== 
