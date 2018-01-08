

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_PRODUCT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_SBON_REFERENCE_STO_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_PRODUCT ADD CONSTRAINT FK_STO_SBON_REFERENCE_STO_PROD FOREIGN KEY (ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_PRODUCT.sql =========***
PROMPT ===================================================================================== 
