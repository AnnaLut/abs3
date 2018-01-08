

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_INF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANSINF_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_INF ADD CONSTRAINT FK_OBPCTRANSINF_OBPCTRANS FOREIGN KEY (TRAN_TYPE)
	  REFERENCES BARS.OBPC_TRANS (TRAN_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS_INF.sql =========*** E
PROMPT ===================================================================================== 
