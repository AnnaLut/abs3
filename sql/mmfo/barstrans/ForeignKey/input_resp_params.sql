PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_RESP_PARAMS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INPUT_RESP_PARAMS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_RESP_PARAMS ADD CONSTRAINT FK_INPUT_RESP_PARAMS_ID FOREIGN KEY (RESP_ID)
	  REFERENCES BARSTRANS.INPUT_RESP (REQ_ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_RESP_PARAMS.sql ======
PROMPT ===================================================================================== 