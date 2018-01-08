

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_P.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_LINESP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P ADD CONSTRAINT FK_LINESP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESP_ZAGF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P ADD CONSTRAINT FK_LINESP_ZAGF FOREIGN KEY (KF, FN, DAT)
	  REFERENCES BARS.ZAG_F (KF, FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_P.sql =========*** End *** 
PROMPT ===================================================================================== 
