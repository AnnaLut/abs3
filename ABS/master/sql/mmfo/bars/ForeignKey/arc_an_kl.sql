

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ARC_AN_KL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ARCANKL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_AN_KL ADD CONSTRAINT FK_ARCANKL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ARC_AN_KL.sql =========*** End **
PROMPT ===================================================================================== 
