

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_GROUPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EBKCGROUPS_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GROUPS ADD CONSTRAINT FK_EBKCGROUPS_CUSTTYPE FOREIGN KEY (CUST_TYPE)
	  REFERENCES BARS.EBKC_CUST_TYPES (CUST_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EBKC_GROUPS.sql =========*** End 
PROMPT ===================================================================================== 
