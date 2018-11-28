PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_MAIN_REQ.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_MAIN_REQ_TYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_MAIN_REQ ADD CONSTRAINT FK_OUT_MAIN_REQ_TYPE_ID FOREIGN KEY (SEND_TYPE)
	  REFERENCES BARSTRANS.OUT_TYPES (TYPE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_MAIN_REQ.sql =========**
PROMPT ===================================================================================== 