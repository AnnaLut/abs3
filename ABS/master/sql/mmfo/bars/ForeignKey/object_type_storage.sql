

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBJECT_TYPE_STORAGE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STORAGE_REF_OBJ_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE ADD CONSTRAINT FK_STORAGE_REF_OBJ_TYPE FOREIGN KEY (OBJECT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBJECT_TYPE_STORAGE.sql =========
PROMPT ===================================================================================== 
