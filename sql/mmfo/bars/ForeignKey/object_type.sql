

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBJECT_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBJECT_TYPE_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE ADD CONSTRAINT FK_OBJECT_TYPE_REF_PARENT FOREIGN KEY (PARENT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBJECT_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
