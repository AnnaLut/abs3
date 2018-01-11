

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CH_KOM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CH_KOM_BIC_E ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_KOM ADD CONSTRAINT FK_CH_KOM_BIC_E FOREIGN KEY (BIC_E)
	  REFERENCES BARS.CH_BIC (BIC_E) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CH_KOM.sql =========*** End *** =
PROMPT ===================================================================================== 
