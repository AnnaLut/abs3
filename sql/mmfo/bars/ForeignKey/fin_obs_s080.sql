

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_OBS_S080.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_FIN_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_FIN_FIN FOREIGN KEY (FIN)
	  REFERENCES BARS.STAN_FIN (FIN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FIN_RISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_FIN_RISK FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OBS_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_OBS_OBS FOREIGN KEY (OBS)
	  REFERENCES BARS.STAN_OBS (OBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_OBS_S080.sql =========*** End
PROMPT ===================================================================================== 
