

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_VALID.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_SWOPT_SWVALID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VALID ADD CONSTRAINT R_SWOPT_SWVALID FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_VALID.sql =========*** End ***
PROMPT ===================================================================================== 
