

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_ACCT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCACCT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ACCT ADD CONSTRAINT FK_OBPCACCT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPC_ACCT_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ACCT ADD CONSTRAINT FK_OBPC_ACCT_FILES FOREIGN KEY (ID)
	  REFERENCES BARS.OBPC_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_ACCT.sql =========*** End **
PROMPT ===================================================================================== 
