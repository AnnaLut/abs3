

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_URI.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_URI2_ADR ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_URI ADD CONSTRAINT FK_OUT_URI2_ADR FOREIGN KEY (ADR_NAME)
      REFERENCES BARSTRANS.OUT_DEST_ADR (ADR_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OUT_URI2_USR ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_URI ADD CONSTRAINT FK_OUT_URI2_USR FOREIGN KEY (USERNAME)
      REFERENCES BARSTRANS.OUT_DEST_USERS (USERNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_URI.sql =========*** End *** 
PROMPT ===================================================================================== 

