

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_RANG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_RANG_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG ADD CONSTRAINT FK_CC_RANG_RANG FOREIGN KEY (RANG)
	  REFERENCES BARS.CC_RANG_NAME (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_RANG_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG ADD CONSTRAINT FK_CC_RANG_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_RANG.sql =========*** End *** 
PROMPT ===================================================================================== 
