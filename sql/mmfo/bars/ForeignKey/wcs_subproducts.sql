

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SUBPRDS_PRDID_PRDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCTS ADD CONSTRAINT FK_SUBPRDS_PRDID_PRDS_ID FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.WCS_PRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SUBPRODUCTS.sql =========*** 
PROMPT ===================================================================================== 
