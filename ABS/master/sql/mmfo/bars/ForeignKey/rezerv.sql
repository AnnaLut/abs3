

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REZERV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_REZERV_REZ0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV ADD CONSTRAINT R_REZERV_REZ0 FOREIGN KEY (ID)
	  REFERENCES BARS.REZ0 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_REZERV_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV ADD CONSTRAINT R_REZERV_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REZERV.sql =========*** End *** =
PROMPT ===================================================================================== 
