

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CP_ACCOUNTSTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_ACCOUNTSTYPES FOREIGN KEY (CP_ACCTYPE)
	  REFERENCES BARS.CP_ACCTYPES (TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_REF FOREIGN KEY (CP_REF)
	  REFERENCES BARS.CP_DEAL (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS ADD CONSTRAINT FK_CP_ACC FOREIGN KEY (CP_ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
