

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_TT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_TIP_CPTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT ADD CONSTRAINT R_TIP_CPTT FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_TT.sql =========*** End *** ==
PROMPT ===================================================================================== 
