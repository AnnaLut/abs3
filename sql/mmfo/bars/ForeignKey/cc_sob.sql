

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_SOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCSOB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB ADD CONSTRAINT FK_CCSOB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK2_CC_SOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB ADD CONSTRAINT FK2_CC_SOB FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK3_CC_SOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB ADD CONSTRAINT FK3_CC_SOB FOREIGN KEY (OTM)
	  REFERENCES BARS.CC_OTM (OTM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK4_CC_SOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB ADD CONSTRAINT FK4_CC_SOB FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_SOB.sql =========*** End *** =
PROMPT ===================================================================================== 
