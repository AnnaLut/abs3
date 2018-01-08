

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LIST_ITEM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ENUM_VAL_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM ADD CONSTRAINT FK_ENUM_VAL_REF_PARENT FOREIGN KEY (LIST_TYPE_ID, PARENT_LIST_ITEM_ID)
	  REFERENCES BARS.LIST_ITEM (LIST_TYPE_ID, LIST_ITEM_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ENUM_VAL_REF_EN_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_ITEM ADD CONSTRAINT FK_ENUM_VAL_REF_EN_TYPE FOREIGN KEY (LIST_TYPE_ID)
	  REFERENCES BARS.LIST_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LIST_ITEM.sql =========*** End **
PROMPT ===================================================================================== 
