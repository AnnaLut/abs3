

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_RANG_NAME.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_RANG_NAME_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_NAME ADD CONSTRAINT FK_CC_RANG_NAME_BLK FOREIGN KEY (BLK)
	  REFERENCES BARS.CC_RANG_ADV_REP_NAME (BLK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_RANG_NAME_CYSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_NAME ADD CONSTRAINT FK_CC_RANG_NAME_CYSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_RANG_NAME.sql =========*** End
PROMPT ===================================================================================== 
