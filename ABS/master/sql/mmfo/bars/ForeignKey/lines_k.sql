

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_K.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_LINES_ZAG_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K ADD CONSTRAINT R_LINES_ZAG_K FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_F (FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K ADD CONSTRAINT FK_LINESK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_K.sql =========*** End *** 
PROMPT ===================================================================================== 
