

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TT_IN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTTIN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN ADD CONSTRAINT FK_OBPCTTIN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTTIN_TTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN ADD CONSTRAINT FK_OBPCTTIN_TTS2 FOREIGN KEY (TT_V)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TT_IN.sql =========*** End *
PROMPT ===================================================================================== 
