

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_GCIF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EBKGCIF_EBKCUSTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GCIF ADD CONSTRAINT FK_EBKGCIF_EBKCUSTTYPES FOREIGN KEY (CUST_TYPE)
	  REFERENCES BARS.EBKC_CUST_TYPES (CUST_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_GCIF.sql =========*** End **
PROMPT ===================================================================================== 
