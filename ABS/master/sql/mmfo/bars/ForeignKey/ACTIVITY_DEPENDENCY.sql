PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/Bars/ForeignKey/ACTIVITY_DEPENDENCY.sql === *** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create constraint FK_ACTIVITY_REFERENCE_ACTIVITY ***

begin   
   execute immediate '
   alter table ACTIVITY_DEPENDENCY
   add constraint FK_ACTIVITY_REFERENCE_ACTIVITY foreign key (PRIMARY_ACTIVITY_ID)
   references ACTIVITY (ID) on delete cascade NOVALIDATE';
exception when others then
   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/Bars/ForeignKey/ACTIVITY_DEPENDENCY.sql === *** End ***
PROMPT ===================================================================================== 
