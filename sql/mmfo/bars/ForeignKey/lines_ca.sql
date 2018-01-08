

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_CA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_LINES_ZAG_CA ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CA ADD CONSTRAINT R_LINES_ZAG_CA FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_TB (FN, DAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESCA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_CA ADD CONSTRAINT FK_LINESCA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_CA.sql =========*** End ***
PROMPT ===================================================================================== 
