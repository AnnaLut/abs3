PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_REQS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INPUT_REQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_REQS ADD CONSTRAINT FK_INPUT_REQS_ID FOREIGN KEY (TYPE_NAME)
	  REFERENCES BARSTRANS.INPUT_TYPES (TYPE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_REQS.sql =========*** 
PROMPT ===================================================================================== 