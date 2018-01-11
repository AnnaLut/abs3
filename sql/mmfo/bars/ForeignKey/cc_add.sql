

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_ADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCADD_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_ACCOUNTS FOREIGN KEY (KF, ACCS)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCSOURCE_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCSOURCE_CCADD FOREIGN KEY (SOUR)
	  REFERENCES BARS.CC_SOURCE (SOUR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TABVAL_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_TABVAL_CCADD FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT XFK_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCAIM_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCAIM_CCADD FOREIGN KEY (AIM)
	  REFERENCES BARS.CC_AIM (AIM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWBANKS2 FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWBANKS FOREIGN KEY (SWI_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCDEAL_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCDEAL_CCADD FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWJOURNAL2 FOREIGN KEY (SWO_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWJOURNAL FOREIGN KEY (SWI_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_ADD.sql =========*** End *** =
PROMPT ===================================================================================== 
