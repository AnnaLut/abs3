

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_ZAY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_ZAY_KLA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_KLA FOREIGN KEY (KLA)
	  REFERENCES BARS.CC_KLA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_ZAY_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_ZAY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCZAY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CCZAY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_ZAY.sql =========*** End *** =
PROMPT ===================================================================================== 
