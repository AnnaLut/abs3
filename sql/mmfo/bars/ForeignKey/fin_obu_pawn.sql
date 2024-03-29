

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_OBU_PAWN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINOBUPAWN_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN ADD CONSTRAINT FK_FINOBUPAWN_PAWN FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINOBUPAWN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBU_PAWN ADD CONSTRAINT FK_FINOBUPAWN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_OBU_PAWN.sql =========*** End
PROMPT ===================================================================================== 
