

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_APPL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_CCDEAL_CCAPPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_APPL ADD CONSTRAINT R_CCDEAL_CCAPPL FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCTIPD_CCAPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_APPL ADD CONSTRAINT R_CCTIPD_CCAPL FOREIGN KEY (TIPD)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCSOS_CCAPPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_APPL ADD CONSTRAINT R_CCSOS_CCAPPL FOREIGN KEY (SOS)
	  REFERENCES BARS.CC_SOS (SOS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_APPL.sql =========*** End *** 
PROMPT ===================================================================================== 
