PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_REQS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_REQS_SEND ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQS ADD CONSTRAINT FK_OUT_REQS_SEND FOREIGN KEY (MAIN_ID)
	  REFERENCES BARSTRANS.OUT_MAIN_REQ (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OUT_REQS_URI ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQS ADD CONSTRAINT FK_OUT_REQS_URI FOREIGN KEY (URI_GR_ID, URI_KF)
	  REFERENCES BARSTRANS.OUT_URI (GR_NAME, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OUT_REQS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_REQS ADD CONSTRAINT FK_OUT_REQS_TYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARSTRANS.OUT_TYPES (TYPE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_REQS.sql =========*** En
PROMPT ===================================================================================== 