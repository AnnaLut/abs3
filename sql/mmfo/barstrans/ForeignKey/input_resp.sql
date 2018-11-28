PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_RESP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INPUT_RESP_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_RESP ADD CONSTRAINT FK_INPUT_RESP_ID FOREIGN KEY (REQ_ID)
	  REFERENCES BARSTRANS.INPUT_REQS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_RESP.sql =========*** 
PROMPT ===================================================================================== 