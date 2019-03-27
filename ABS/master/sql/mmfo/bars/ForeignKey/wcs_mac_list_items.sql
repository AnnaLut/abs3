

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_MAC_LIST_ITEMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MACLISTITEMS_MID_MACS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_LIST_ITEMS ADD CONSTRAINT FK_MACLISTITEMS_MID_MACS_ID FOREIGN KEY (MAC_ID)
	  REFERENCES BARS.WCS_MACS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_MAC_LIST_ITEMS.sql =========*
PROMPT ===================================================================================== 