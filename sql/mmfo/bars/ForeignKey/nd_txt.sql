

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ND_TXT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NDTXT_CCTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT ADD CONSTRAINT FK_NDTXT_CCTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.CC_TAG (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NDTXT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT ADD CONSTRAINT FK_NDTXT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ND_TXT.sql =========*** End *** =
PROMPT ===================================================================================== 
