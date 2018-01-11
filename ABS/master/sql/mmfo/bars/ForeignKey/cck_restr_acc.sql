

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CCK_RESTR_ACC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCKRESTRACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_ACC ADD CONSTRAINT FK_CCKRESTRACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CCK_RESTR_ACC.sql =========*** En
PROMPT ===================================================================================== 
