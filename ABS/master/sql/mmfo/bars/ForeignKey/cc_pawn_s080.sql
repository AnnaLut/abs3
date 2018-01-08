

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_PAWN_S080.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_PS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 ADD CONSTRAINT FK_CC_PS1 FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_PS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S080 ADD CONSTRAINT FK_CC_PS2 FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_PAWN_S080.sql =========*** End
PROMPT ===================================================================================== 
