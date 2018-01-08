

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_DEB_23.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCDEB23_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_FIN FOREIGN KEY (FIN)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCDEB23_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_OBS FOREIGN KEY (OBS)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCDEB23_KAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_KAT FOREIGN KEY (KAT)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_DEB_23.sql =========*** End *
PROMPT ===================================================================================== 
