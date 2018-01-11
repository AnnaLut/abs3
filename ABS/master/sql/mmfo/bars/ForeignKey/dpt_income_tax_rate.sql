

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INCOME_TAX_RATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTINCOMETAXRATE_ATTRINCOME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INCOME_TAX_RATE ADD CONSTRAINT FK_DPTINCOMETAXRATE_ATTRINCOME FOREIGN KEY (ATTR_INCOME)
	  REFERENCES BARS.ATTRIBUTE_INCOME (ATTR_INCOME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INCOME_TAX_RATE.sql =========
PROMPT ===================================================================================== 
