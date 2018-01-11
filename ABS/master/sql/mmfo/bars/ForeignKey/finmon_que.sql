

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINMONQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE ADD CONSTRAINT FK_FINMONQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMONQUE_FINMONQUE_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE ADD CONSTRAINT R_FINMONQUE_FINMONQUE_STATUS FOREIGN KEY (STATUS)
	  REFERENCES BARS.FINMON_QUE_STATUS (STATUS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QUE_CUSTOMERA ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE ADD CONSTRAINT R_FINMON_QUE_CUSTOMERA FOREIGN KEY (RNK_A)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FINMON_QUE_CUSTOMERB ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE ADD CONSTRAINT R_FINMON_QUE_CUSTOMERB FOREIGN KEY (RNK_B)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_QUE.sql =========*** End *
PROMPT ===================================================================================== 
