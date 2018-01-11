

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_SWTRACE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCSWTRACE_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_SWBANKS FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSWTRACE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCSWTRACE_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SWTRACE ADD CONSTRAINT FK_CCSWTRACE_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_SWTRACE.sql =========*** End *
PROMPT ===================================================================================== 
