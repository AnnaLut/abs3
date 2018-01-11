

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_IN.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANSIN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_IN ADD CONSTRAINT FK_OBPCTRANSIN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_IN.sql =========*** En
PROMPT ===================================================================================== 
