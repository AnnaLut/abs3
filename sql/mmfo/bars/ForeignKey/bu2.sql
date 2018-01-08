

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BU2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BU2_BU1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU2 ADD CONSTRAINT FK_BU2_BU1 FOREIGN KEY (ID)
	  REFERENCES BARS.BU1 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BU2_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU2 ADD CONSTRAINT FK_BU2_DK FOREIGN KEY (PAP)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BU2.sql =========*** End *** ====
PROMPT ===================================================================================== 
