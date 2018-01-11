

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TYPES_OT_OBJTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TYPES ADD CONSTRAINT FK_TYPES_OT_OBJTYPES_ID FOREIGN KEY (OBJECT_TYPE)
	  REFERENCES BARS.INS_OBJECT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
