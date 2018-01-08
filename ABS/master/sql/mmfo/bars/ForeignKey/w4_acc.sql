

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4ACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANFIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANFIN23 FOREIGN KEY (FIN23)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANKAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANKAT23 FOREIGN KEY (KAT23)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANOBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANOBS23 FOREIGN KEY (OBS23)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
