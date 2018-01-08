

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_QUEUE_OBJECTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_QUEUEOBJECTS_REFOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_OBJECTS ADD CONSTRAINT FK_QUEUEOBJECTS_REFOBJECTS FOREIGN KEY (ID)
	  REFERENCES BARS.NBUR_REF_OBJECTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_QUEUE_OBJECTS.sql =========*
PROMPT ===================================================================================== 
