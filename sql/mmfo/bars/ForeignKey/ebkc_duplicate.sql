

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_DUPLICATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EBKCDUPL_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_DUPLICATE ADD CONSTRAINT FK_EBKCDUPL_CUSTTYPE FOREIGN KEY (CUST_TYPE)
	  REFERENCES BARS.EBKC_CUST_TYPES (CUST_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_DUPLICATE.sql =========*** E
PROMPT ===================================================================================== 
