PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_QUEUE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_QUEUE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_QUEUE ADD CONSTRAINT FK_OUT_QUEUE_ID FOREIGN KEY (REQ_ID)
	  REFERENCES BARSTRANS.OUT_REQS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_QUEUE.sql =========*** E
PROMPT ===================================================================================== 