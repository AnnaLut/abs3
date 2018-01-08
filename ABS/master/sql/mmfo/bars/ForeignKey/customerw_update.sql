

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERWUPDATE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW_UPDATE ADD CONSTRAINT FK_CUSTOMERWUPDATE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 
