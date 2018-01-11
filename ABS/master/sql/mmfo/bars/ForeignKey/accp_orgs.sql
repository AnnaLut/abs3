

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCP_ORGS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCPORGS_ORDERFEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT FK_ACCPORGS_ORDERFEE FOREIGN KEY (ORDER_FEE)
	  REFERENCES BARS.ACCP_ORDER_FEE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCPORGS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT FK_ACCPORGS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCPORGS_FEETARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT FK_ACCPORGS_FEETARIF FOREIGN KEY (KF, FEE_BY_TARIF)
	  REFERENCES BARS.TARIF (KF, KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCPORGS_FEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT FK_ACCPORGS_FEETYPE FOREIGN KEY (FEE_TYPE_ID)
	  REFERENCES BARS.ACCP_FEE_TYPES (FEE_TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCP_ORGS.sql =========*** End **
PROMPT ===================================================================================== 
