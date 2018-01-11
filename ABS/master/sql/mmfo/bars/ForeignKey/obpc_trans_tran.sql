

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_TRAN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANSTR_TRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN ADD CONSTRAINT FK_OBPCTRANSTR_TRANS FOREIGN KEY (TRAN_TYPE)
	  REFERENCES BARS.OBPC_TRANS (TRAN_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSTR_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN ADD CONSTRAINT FK_OBPCTRANSTR_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSTR_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN ADD CONSTRAINT FK_OBPCTRANSTR_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_TRAN.sql =========*** 
PROMPT ===================================================================================== 
