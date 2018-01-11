

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FX_DEAL_REF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FXDEALREF_FXDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_REF ADD CONSTRAINT FK_FXDEALREF_FXDEAL FOREIGN KEY (DEAL_TAG)
	  REFERENCES BARS.FX_DEAL (DEAL_TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FX_DEAL_REF.sql =========*** End 
PROMPT ===================================================================================== 
