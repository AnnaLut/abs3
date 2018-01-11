

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_FIELD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTVIDDFIELD_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT FK_DPTVIDDFIELD_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDFIELD_DPTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FIELD ADD CONSTRAINT FK_DPTVIDDFIELD_DPTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.DPT_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_FIELD.sql =========*** E
PROMPT ===================================================================================== 
