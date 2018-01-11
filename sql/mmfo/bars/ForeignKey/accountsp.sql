

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTSP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOUNTSP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSP_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSP_SPARAM_LIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSP ADD CONSTRAINT FK_ACCOUNTSP_SPARAM_LIST FOREIGN KEY (PARID)
	  REFERENCES BARS.SPARAM_LIST (SPID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTSP.sql =========*** End **
PROMPT ===================================================================================== 
