

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_KOL2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_KOL2_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL2 ADD CONSTRAINT FK_CC_KOL2_TIP FOREIGN KEY (TBLANK)
	  REFERENCES BARS.CC_KOL_TBLANK (TBLANK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_KOL2.sql =========*** End *** 
PROMPT ===================================================================================== 
