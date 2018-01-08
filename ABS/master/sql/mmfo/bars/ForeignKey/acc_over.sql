

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_OVER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS FOREIGN KEY (KF, ACC_2096)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS2 FOREIGN KEY (KF, ACCO)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS3 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS4 FOREIGN KEY (KF, ACC_9129)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS5 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS5 FOREIGN KEY (KF, ACC_8000)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS6 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS6 FOREIGN KEY (KF, ACC_2069)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_STANFIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_STANFIN23 FOREIGN KEY (FIN23)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_STANOBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_STANOBS23 FOREIGN KEY (OBS23)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_STANKAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_STANKAT23 FOREIGN KEY (KAT23)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVER_ACCOUNTS7 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT FK_ACCOVER_ACCOUNTS7 FOREIGN KEY (KF, ACC_2067)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_OVER.sql =========*** End ***
PROMPT ===================================================================================== 
