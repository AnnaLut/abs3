

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ARC_RRP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ARC_RRP_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARC_RRP_OPER FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_OPER2 FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_BANKS2 FOREIGN KEY (MFOA)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCRRP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_RRP ADD CONSTRAINT FK_ARCRRP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ARC_RRP.sql =========*** End *** 
PROMPT ===================================================================================== 
