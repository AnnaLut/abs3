

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_TAGS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSBCKTAGS_WCSBCKXMLBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_TAGS ADD CONSTRAINT FK_WCSBCKTAGS_WCSBCKXMLBLK FOREIGN KEY (TAG_BLOCK)
	  REFERENCES BARS.WCS_BCK_XMLBLOCKS (BLOCK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_TAGS.sql =========*** End
PROMPT ===================================================================================== 
