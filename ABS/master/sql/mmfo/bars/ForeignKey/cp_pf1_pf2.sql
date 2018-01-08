

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_PF1_PF2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CP_PF1PF2_PF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PF1_PF2 ADD CONSTRAINT FK_CP_PF1PF2_PF2 FOREIGN KEY (PF2)
	  REFERENCES BARS.CP_PF (PF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_PF1PF2_PF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PF1_PF2 ADD CONSTRAINT FK_CP_PF1PF2_PF1 FOREIGN KEY (PF1)
	  REFERENCES BARS.CP_PF (PF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_PF1_PF2.sql =========*** End *
PROMPT ===================================================================================== 
