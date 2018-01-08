

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_VIDD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_DOX_CPVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD ADD CONSTRAINT R_DOX_CPVIDD FOREIGN KEY (DOX)
	  REFERENCES BARS.CP_DOX (DOX) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PF_CPVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD ADD CONSTRAINT R_PF_CPVIDD FOREIGN KEY (PF)
	  REFERENCES BARS.CP_PF (PF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCTIPD_CPVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD ADD CONSTRAINT R_CCTIPD_CPVIDD FOREIGN KEY (TIPD)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_EMI_CPVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VIDD ADD CONSTRAINT R_EMI_CPVIDD FOREIGN KEY (EMI)
	  REFERENCES BARS.CP_EMI (EMI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_VIDD.sql =========*** End *** 
PROMPT ===================================================================================== 
