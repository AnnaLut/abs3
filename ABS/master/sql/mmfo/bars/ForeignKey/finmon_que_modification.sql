

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE_MODIFICATION.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINMONQUEMODIFICATION_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT FK_FINMONQUEMODIFICATION_ID FOREIGN KEY (ID)
	  REFERENCES BARS.FINMON_QUE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QMOD_MODTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT R_FINMON_QMOD_MODTYPE FOREIGN KEY (MOD_TYPE)
	  REFERENCES BARS.FINMON_QUE_MODTYPE (MOD_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QMOD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT R_FINMON_QMOD_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINMONQUEMODIFICATION_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODIFICATION ADD CONSTRAINT FK_FINMONQUEMODIFICATION_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE_MODIFICATION.sql =====
PROMPT ===================================================================================== 
