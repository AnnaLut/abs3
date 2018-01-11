

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_OUT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANSOUT_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_OBPCTRANS FOREIGN KEY (TRAN_TYPE, DK)
	  REFERENCES BARS.OBPC_TRANS (TRAN_TYPE, DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_OWMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_OWMSGCODE FOREIGN KEY (W4_MSGCODE, DK)
	  REFERENCES BARS.OW_MSGCODE (MSGCODE, DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_OUT.sql =========*** E
PROMPT ===================================================================================== 
