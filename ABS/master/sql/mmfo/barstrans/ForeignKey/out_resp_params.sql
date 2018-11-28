PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_RESP_PARAMS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_RESP_PARAMS_SEND ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_RESP_PARAMS ADD CONSTRAINT FK_OUT_RESP_PARAMS_SEND FOREIGN KEY (REQ_ID)
	  REFERENCES BARSTRANS.OUT_REQS (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_RESP_PARAMS.sql ========
PROMPT ===================================================================================== 