

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_DOCMSG_ERR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWDOCMSGERR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_DOCMSG_ERR ADD CONSTRAINT FK_SWDOCMSGERR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_DOCMSG_ERR.sql =========*** En
PROMPT ===================================================================================== 
