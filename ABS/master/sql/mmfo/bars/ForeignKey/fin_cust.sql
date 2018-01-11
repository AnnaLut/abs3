

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_CUST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINCUST_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_CUST ADD CONSTRAINT FK_FINCUST_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_CUST.sql =========*** End ***
PROMPT ===================================================================================== 
