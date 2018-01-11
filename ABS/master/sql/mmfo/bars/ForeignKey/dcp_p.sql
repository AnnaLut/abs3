

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DCP_P.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DCPP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P ADD CONSTRAINT FK_DCPP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DCP_FN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P ADD CONSTRAINT FK_DCP_FN FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.DCP_ZAG (FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DCP_P.sql =========*** End *** ==
PROMPT ===================================================================================== 
