

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_PAWN_S_PAWN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_PAWN_S_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN_S_PAWN ADD CONSTRAINT FK_CC_PAWN_S_PAWN FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_PAWN_S_PAWN.sql =========*** E
PROMPT ===================================================================================== 
