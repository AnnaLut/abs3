

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_SUBJECTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTSUBJ_GRTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_SUBJECTS ADD CONSTRAINT FK_GRTSUBJ_GRTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.GRT_TYPES (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_SUBJECTS.sql =========*** End
PROMPT ===================================================================================== 
