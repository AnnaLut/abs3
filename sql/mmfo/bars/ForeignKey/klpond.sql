

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLPOND.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPOND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND ADD CONSTRAINT FK_KLPOND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPOND_KLP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPOND ADD CONSTRAINT FK_KLPOND_KLP FOREIGN KEY (KF, FILENAME, POND)
	  REFERENCES BARS.KLP (KF, NAEX, POND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLPOND.sql =========*** End *** =
PROMPT ===================================================================================== 
