

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEP_FILIAL_PAY_DETAILS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SEPFLPAYDETAILS_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS ADD CONSTRAINT FK_SEPFLPAYDETAILS_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEP_FILIAL_PAY_DETAILS.sql ======
PROMPT ===================================================================================== 
