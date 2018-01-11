

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_RYN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CP_RYN_TIPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RYN ADD CONSTRAINT FK_CP_RYN_TIPD FOREIGN KEY (TIPD)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_RYN.sql =========*** End *** =
PROMPT ===================================================================================== 
