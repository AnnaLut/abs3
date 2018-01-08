

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_MSGTAG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWMSGTAG_SWMSGBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG ADD CONSTRAINT FK_SWMSGTAG_SWMSGBLK FOREIGN KEY (MSGBLK)
	  REFERENCES BARS.SW_MSGBLK (MSGBLK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_MSGTAG.sql =========*** End **
PROMPT ===================================================================================== 
