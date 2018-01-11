

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_F.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_LINESF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT FK_LINESF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_LINES_ZAG_F ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT R_LINES_ZAG_F FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_F (FN, DAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_F.sql =========*** End *** 
PROMPT ===================================================================================== 
