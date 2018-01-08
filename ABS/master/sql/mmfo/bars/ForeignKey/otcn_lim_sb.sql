

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_LIM_SB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTCNLIMSB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB ADD CONSTRAINT FK_OTCNLIMSB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTCN_LIM_SB.sql =========*** End 
PROMPT ===================================================================================== 
