

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_PROD_EXTRA_ATTRIBUTES.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EXT_ATTRIB_REF_STO_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PROD_EXTRA_ATTRIBUTES ADD CONSTRAINT FK_EXT_ATTRIB_REF_STO_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_PROD_EXTRA_ATTRIBUTES.sql ===
PROMPT ===================================================================================== 
