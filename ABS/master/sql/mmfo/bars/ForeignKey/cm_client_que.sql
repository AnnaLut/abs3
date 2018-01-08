

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CM_CLIENT_QUE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CMCLIENTQUE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT FK_CMCLIENTQUE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CMCLIENTQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT FK_CMCLIENTQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CM_CLIENT_QUE.sql =========*** En
PROMPT ===================================================================================== 
