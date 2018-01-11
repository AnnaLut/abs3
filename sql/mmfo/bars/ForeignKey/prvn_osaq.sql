

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PRVN_OSAQ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PRVNOSAQ_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_OSAQ ADD CONSTRAINT FK_PRVNOSAQ_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PRVN_OSAQ.sql =========*** End **
PROMPT ===================================================================================== 
