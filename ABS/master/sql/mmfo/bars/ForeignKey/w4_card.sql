

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_CARD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4CARD_W4SUBPRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT FK_W4CARD_W4SUBPRODUCT FOREIGN KEY (SUB_CODE)
	  REFERENCES BARS.W4_SUBPRODUCT (CODE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4CARD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_CARD ADD CONSTRAINT FK_W4CARD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_CARD.sql =========*** End *** 
PROMPT ===================================================================================== 
