

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCDEAL_STANKAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT FK_CCDEAL_STANKAT23 FOREIGN KEY (KAT23)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCDEAL_STANOBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT FK_CCDEAL_STANOBS23 FOREIGN KEY (OBS23)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCVIDD_CCDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT R_CCVIDD_CCDEAL FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCDEAL_STANFIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT FK_CCDEAL_STANFIN23 FOREIGN KEY (FIN23)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCSOS_CCDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT R_CCSOS_CCDEAL FOREIGN KEY (SOS)
	  REFERENCES BARS.CC_SOS (SOS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
