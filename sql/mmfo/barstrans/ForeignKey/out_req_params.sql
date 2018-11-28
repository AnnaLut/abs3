PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_REQ_PARAMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_REQ_PARAMS_REQ_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQ_PARAMS ADD CONSTRAINT FK_OUT_REQ_PARAMS_REQ_ID FOREIGN KEY (REQ_ID)
	  REFERENCES BARSTRANS.OUT_MAIN_REQ (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_REQ_PARAMS.sql =========
PROMPT ===================================================================================== 