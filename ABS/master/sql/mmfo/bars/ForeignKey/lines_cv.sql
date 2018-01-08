

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_CV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_LINES_ZAG_CV ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CV ADD CONSTRAINT R_LINES_ZAG_CV FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_TB (FN, DAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESCV_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CV ADD CONSTRAINT FK_LINESCV_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_CV.sql =========*** End ***
PROMPT ===================================================================================== 
