

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BOPBANK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BOPBANK_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BOPBANK ADD CONSTRAINT FK_BOPBANK_SWBANKS FOREIGN KEY (BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BOPBANK.sql =========*** End *** 
PROMPT ===================================================================================== 
